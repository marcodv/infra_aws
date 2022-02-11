/* 
 * This module is used to deploy Prometheus using Helm provider from Terraform
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

// MOVE THESE HELM IN SEPARATE FILES

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
