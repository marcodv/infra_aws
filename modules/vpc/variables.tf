variable "environment" {
  description = "Environments that we want to deploy"
  type        = string
}

variable "vpc_cidr_block" {
  description = "VPC cidr block"
  type        = string
}

variable "public_subnets_cidr" {
  description = "List of cidr blocks"
  type        = list(string)
}

variable "private_subnets_cidr" {
  description = "List of cidr blocks"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "alb_ingress_rule" {
  description = "List of open ports for inbound connections"
  type        = list(number)
}

variable "eks_ingress_rule" {
  description = "List of open ports for inbound connections"
  type        = list(number)
}

variable "bastion_ingress_rule" {
  description = "List of open ports for inbound connections"
  type        = list(number)
}

variable "private_instances_ingress_rule" {
  description = "List of open ports for inbound connections"
  type        = list(number)
}

variable "acl_public_subnet_rule" {
  description = "List of rule_no and inbound ports open"
  type = object({
    ingress_rule = list(object({
      rule_no   = number
      from_port = number
      to_port   = number
    }))
  })
}

variable "acl_private_subnet_rule" {
  description = "List of rule_no and inbound ports open"
  type = object({
    ingress_rule = list(object({
      rule_no   = number
      from_port = number
      to_port   = number
    }))
  })
}

variable "acl_db_rule" {
  description = "List of rule_no and inbound ports open"
  type = object({
    ingress_rule = list(object({
      rule_no   = number
      from_port = number
      to_port   = number
    }))
  })
}

variable "db_subnets_cidr" {
  description = "List of private subnets for DB"
  type        = list(string)
  default     = []
}

variable "sg_db_rule" {
  description = "List of open ports for inbound connections"
  type        = list(string)
}

