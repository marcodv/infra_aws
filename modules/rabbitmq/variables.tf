variable "environment" {
  description = "Environments that we want to deploy"
  type        = string
}

variable "rabbitmq_settings" {
  description = "List of settings for RabbitMQ instance"
  type = object({
    engine_version     = string
    host_instance_type = string
    security_groups    = list(string)
    subnets_ids        = list(string)
  })
}
