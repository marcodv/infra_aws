variable "environment" {
  description = "Environments that we want to deploy"
  type = string
}
variable "vpc_cidr_block" {
  description = "VPC cidr block"
  type = string
}
variable "public_subnets_cidr" {
  description = "List of cidr blocks"
  type = list(string)
}
variable "private_subnets_cidr" {
  description = "List of cidr blocks"
  type = list(string)
}
variable "availability_zones" {
  description = "List of availability zones"
  type = list(string)
}
variable "bastions-ami" {
  description = "Ami id used to create bastion"
  type = string
}
variable "bastion_ingress_rule" {
  description = "List of inbound ports open"
  type = list(number)
}
variable "public_subnet_alb" {
  description = "List of public subnets for ALB"
  default = ""
}
variable "sg_alb" {
  description = "Security group for ALB"
  default = ""
}
variable "vpc_id" {
  description = "VPC id"
  default = ""
}

variable "alb_ingress_rule" {
  description = "List of inbound ports open"
  type = list(number)
}

variable "private_instances_ingress_rule" {
  description = "List of inbound ports open"
  type = list(number)
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

variable "db_master_password" {
  description = "Master password for db"
  type = string
}

variable "db_master_username" {
  description = "Master username for db"
  type = string
}

variable "eks_cluster_role" {
  description = "Role for EKS"
  type    = string
  default = ""
}

variable "db_private_subnets_cidr" {
  description = "List of private subnets for DB"
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

variable "type_resource" {
  type = string
}

variable "iam_eks_policies" {
  type = list(string)
}