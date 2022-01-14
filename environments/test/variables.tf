variable "environment" {}
variable "vpc_cidr_block" {}
variable "public_subnets_cidr" {}
variable "private_subnets_cidr" {}
variable "availability_zones" {}
variable "bastions-ami" {}
variable "bastion_ingress_rule" {}
variable "public_subnet_alb" {
  default = ""
}
variable "sg_alb" {
  default = ""
}
variable "vpc_id" {
  default = ""
}

variable "alb_ingress_rule" {
  type = list(number)
}

variable "private_instances_ingress_rule" {
  type = list(number)
}

variable "acl_public_subnet_rule" {
  type = map(any)
}

variable "acl_private_subnet_rule" {
  type = map(any)
}

variable "acl_db_rule" {}

variable "db_master_password" {}

variable "db_master_username" {}

variable "eks_cluster_role" {
  type    = string
  default = ""
}

variable "db_private_subnets_cidr" {
  type = list(string)
  default = []
}

variable "sg_db_rule" {}