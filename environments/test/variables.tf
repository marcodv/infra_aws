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
  type = object({
    ingress_rule = list(object({
      rule_no   = number
      from_port = number
      to_port   = number
    }))
  })
}

variable "acl_private_subnet_rule" {
  type = object({
    ingress_rule = list(object({
      rule_no   = number
      from_port = number
      to_port   = number
    }))
  })
}

variable "acl_db_rule" {
  type = object({
    ingress_rule = list(object({
      rule_no   = number
      from_port = number
      to_port   = number
    }))
  })
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
  type = object({
    admins = list(object({
      groups   = list(string)
      userarn  = string
      username = string
    }))
  })
}

variable "read_only_eks_users" {
  type = object({
    users = list(object({
      groups   = list(string)
      userarn  = string
      username = string
    }))
  })
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
  type = list(object({
    api_groups = list(string)
    resources  = list(string)
    verbs      = list(string)
  }))
}

variable "read_only_user_permissions" {
  type = list(object({
    api_groups = list(string)
    resources  = list(string)
    verbs      = list(string)
  }))
}

variable "workers_nodes_instance_type" {
  type = list(string)
}

variable "worker_nodes_scaling_config" {
  type = object({
    desired_size = number
    max_size     = number
    min_size     = number
  })
}

variable "worker_nodes_update_config" {
  type = object({
    max_unavailable = number
  })
}

variable "worker_node_ami_id" {
  type = string
}

variable "eks_version" {
  type = string
}