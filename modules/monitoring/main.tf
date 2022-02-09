/* 
 * This module is used to deploy Prometheus and Grafana using Helm provider from Terraform
 *
 * Prometheus is used to gather metrics and then these will be displayed from Grafana
 *
 * In this folder there is the Grafana config template
 *  
 * 
 * At this stage, will be setup 2 dashboard which will show
 *
 * - Node metrics with CPU, Memory 
 * - Pods metrics
 * 
*/

resource "helm_release" "prometheus" {
  chart      = "prometheus"
  name       = "prometheus"
  namespace  = "monitoring"
  repository = "https://prometheus-community.github.io/helm-charts"

  # When you want to directly specify the value of an element in a map you need \\ to escape the point.
  set {
    name  = "podSecurityPolicy\\.enabled"
    value = true
  }

  set {
    name  = "server\\.persistentVolume\\.enabled"
    value = false
  }

  set {
    name = "server\\.resources"
    # You can provide a map of value using yamlencode  
    value = yamlencode({
      limits = {
        cpu    = "200m"
        memory = "50Mi"
      }
      requests = {
        cpu    = "100m"
        memory = "30Mi"
      }
    })
  }
}


data "template_file" "grafana_values" {
  template = file("${path.module}/templates/grafana-values.yaml")
  #count    = length(var.grafana_dashboard_list)

  vars = {
    GRAFANA_SERVICE_ACCOUNT = "grafana"
    GRAFANA_ADMIN_USER      = "admin"
    GRAFANA_ADMIN_PASSWORD  = "TestingPassword123456"
    PROMETHEUS_SVC          = "${helm_release.prometheus.name}-server"
    NAMESPACE               = "monitoring"
    GRAFANA_VERSION         = "${var.grafana_setting.grafana_version}"
    EKS_ENVIRONMENT         = "${var.environment}"
    DASHBOARD_PATH          = "${path.module}/grafana-dashboard/"
    #DASHBOARD_NAME          = file("${path.module}/grafana-dashboard/${element(var.grafana_dashboard_list, count.index)}.json")
    DASHBOARD_NAME          = "cluster-pod-dashboard.json"
  }
}

resource "helm_release" "grafana" {
  chart      = "grafana"
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  namespace  = "monitoring"


  // iterate over the list of dashboards to import
  values = [
    data.template_file.grafana_values.rendered
  ]
}
