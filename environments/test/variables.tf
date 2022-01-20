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
  /*type = list(object({
    rule_no   = number
    from_port = number
    to_port   = number
  })) */
}

variable "acl_private_subnet_rule" {
type = map(any)
}

variable "acl_db_rule" {
type = map(any)
}

variable "db_master_password" {
  type = string
}

variable "db_master_username" {
  type = string
}

variable "eks_cluster_role" {
  type    = string
  default = ""
}

variable "db_private_subnets_cidr" {
  type    = list(string)
  default = []
}

variable "sg_db_rule" {
  type = list(string)
}

variable "map_cluster_admin_users" {
type = map(any)
}

variable "read_only_eks_users" {
type = map(any)
}

variable "namespaces" {
  type = list(object({
    manage = string
    name   = string
    custom_annotations = list(object({
      label = string
      value = string
    }))
    custom_labels = list(object({
      label = string
      value = string
    }))
  }))
}

variable "cluster_admin_permissions" {
  type = list(any)
}

variable "read_only_user_permissions" {
  type = list(any)
}

/*variable "cluster_admin_permissions" {
  type = list(object({
    resource_type_empty = list(object({
      api_groups = list(string)
      resources  = list(string)
      verbs      = list(string)
    })),
    resources_type_apps = list(object({
      api_groups = list(string)
      resources  = list(string)
      verbs      = list(string)
    })),
    resources_type_batch = list(object({
      api_groups = list(string)
      resources  = list(string)
      verbs      = list(string)
    }))
  }))
} */
