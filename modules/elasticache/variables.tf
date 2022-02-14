variable "environment" {
  description = "Environments that we want to deploy"
  type        = string
}

variable "elasticache_setting" {
  description = "List for the Elastic Cache Redis based engine instance setting"
  type = object({
    engine               = string
    node_type            = string
    num_cache_nodes      = number
    port                 = number
    engine_version       = string
  })
}

variable "subnet_group_name" {
  description = "Subnets for Elasticache"
  type = string
}

variable "security_group_ids" {
  description = "Security groups ids for Elasticache"
  type = list(string)
}