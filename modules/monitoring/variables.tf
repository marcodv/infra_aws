variable "environment" {
  description = "Environments that we want to deploy"
  type        = string
}

variable "cluster_name" {
  description = "Cluster name"
  type        = string
}

variable "grafana_setting" {
  description = "List of Grafana setting to apply to deployment"
  type = object({
    persistence_enabled = string
    storage_class       = string
    storage_size        = string
    helm_chart_version  = string
  })
}

variable "grafana_dashboard_list" {
  description = "Grafana dashboard list to import on EKS"
  type        = list(string)
}

variable "grafana_access_credentials" {
  description = "These are the creds set for access to Grafana dashboard"
  type = object({
    username = string
    password = string
  })
}

variable "prometheus_setting" {
  description = "Setting for Prometheus"
  type = object({
    prometheus_version = string
  })
}
