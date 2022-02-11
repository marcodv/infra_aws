variable "environment" {
  description = "Environments that we want to deploy"
  type        = string
}

variable "cluster_name" {
  description = "Cluster name"
  type        = string
}

variable "grafana_setting" {
  description = "List of Grafana setting to apply to template"
  type = object({
    grafana_version = string
  })
}

variable "grafana_dashboard_list" {
  description =  "Grafana dashboard list to import on EKS"
  type = list(string)
}

variable "grafana_access_credentials" {
  description = "These are the creds set for access to Grafana dashboard"
  type = object({
    username = string
    password = string
  })
}