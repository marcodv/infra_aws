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

// Setup Grafana config values
data "template_file" "grafana_values" {
  template = file("${path.module}/templates/grafana-values.yaml")
  #count    = length(var.grafana_dashboard_list)

  vars = {
    GRAFANA_SERVICE_ACCOUNT = "grafana"
    GRAFANA_ADMIN_USER      = "${var.grafana_access_credentials.username}"
    GRAFANA_ADMIN_PASSWORD  = "${var.grafana_access_credentials.password}"
    PROMETHEUS_SVC          = "${helm_release.prometheus.name}-server"
    NAMESPACE               = "monitoring"
    GRAFANA_VERSION         = "${var.grafana_setting.grafana_version}"
    EKS_ENVIRONMENT         = "${var.environment}"
    DASHBOARD_PATH          = "/grafana-dashboard"
    #DASHBOARD_NAME          = file("${path.module}/grafana-dashboard/${element(var.grafana_dashboard_list, count.index)}.json")
    #DASHBOARD_NAME          = "dashboard-with-pod.json"
  }
}

// Setup Grafana via Helm
resource "helm_release" "grafana" {
  chart      = "grafana"
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  namespace  = "monitoring"

  values = [
    data.template_file.grafana_values.rendered
  ]
}

/*
resource "grafana_dashboard" "dashboards" {
  count      = length(var.grafana_dashboard_list)
  config_json = file("${path.module}/grafana-dashboards/${element(var.grafana_dashboard_list, count.index)}")
}*/