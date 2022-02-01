variable "environment" {}

variable "public_subnet_alb" {}

variable "sg_alb" {}

variable "vpc_id" {}

variable "eks_ingress_controller_port_path" {
  type = object({
    ingress_port     = number
    healt_check_path = string
  })
}