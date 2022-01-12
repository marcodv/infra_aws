variable "environment" {}

variable "vpc_cidr_block" {}

variable "public_subnets_cidr" {}

variable "availability_zones" {}

variable "private_subnets_cidr" {}

variable "alb_ingress_rule" {}

variable "bastion_ingress_rule" {}

variable "private_instances_ingress_rule" {}

variable "bastions-ami" {}

variable "acl_public_subnet_rule" {}

variable "acl_private_subnet_rule" {}

variable "acl_db_rule" {}
