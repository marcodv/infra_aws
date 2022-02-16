variable "environment" {
  description = "Environments that we want to deploy"
  type        = string
}

variable "rabbitmq_settings" {
  description = "List of settings for RabbitMQ instance"
  type = object({
    engine_version     = string
    host_instance_type = string
  })
}

variable "subnet_group_name_rabbitmq" {
  description = "Subnets for RabbitMQ instance"
  type        = string
}

variable "security_group_id_rabbitmq" {
  description = "Security groups ids for RabbitMQ"
  type        = list(string)
}