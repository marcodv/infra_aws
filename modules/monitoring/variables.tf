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
