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

variable "bastions-ami" {
  description = "Ami id used to create bastion"
  type        = string
}

variable "bastion_ingress_rule" {
  description = "List of open ports for inbound connections"
  type        = list(number)
}

variable "public_subnet_alb" {
  description = "List of public subnets for ALB"
  default     = ""
}

variable "sg_alb" {
  description = "Security group for ALB"
  default     = ""
}

variable "vpc_id" {
  description = "VPC id"
  default     = ""
}

variable "alb_ingress_rule" {
  description = "List of open ports for inbound connections"
  type        = list(number)
}

variable "eks_ingress_rule" {
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

variable "db_master_password" {
  description = "Master password for db"
  type        = string
}

variable "db_master_username" {
  description = "Master username for db"
  type        = string
}

variable "db_private_subnets_cidr" {
  description = "List of private subnets for DB"
  type        = list(string)
  default     = []
}

variable "sg_db_rule" {
  description = "List of open ports for inbound connections"
  type        = list(string)
}

variable "map_cluster_admin_users" {
  description = "Map of full admin users on EKS"
  type = object({
    admins = list(object({
      groups   = list(string)
      userarn  = string
      username = string
    }))
  })
}

variable "read_only_eks_users" {
  description = "Map of read only users on EKS"
  type = object({
    users = list(object({
      groups   = list(string)
      userarn  = string
      username = string
    }))
  })
}

variable "namespaces" {
  description = "List of namespaces created on EKS"
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
  description = "List of permissions granted to admins users"
  type = list(object({
    api_groups = list(string)
    resources  = list(string)
    verbs      = list(string)
  }))
}

variable "read_only_user_permissions" {
  description = "List of permissions granted to read only users"
  type = list(object({
    api_groups = list(string)
    resources  = list(string)
    verbs      = list(string)
  }))
}

variable "workers_nodes_instance_type" {
  description = "Instance type for worker node"
  type        = list(string)
}

variable "worker_nodes_scaling_config" {
  description = "Setting for scaling nodes in EKS"
  type = object({
    desired_size = number
    max_size     = number
    min_size     = number
  })
}

variable "worker_nodes_update_config" {
  description = "Max number of unavailable nodes at the same time"
  type = object({
    max_unavailable = number
  })
}

variable "eks_version" {
  description = "EKS version"
  type        = string
}

variable "type_resource" {
  description = "Type of resource created by terraform. Values can be [durable,destroyable]"
  type        = string
}

// change this variable name
variable "eks_ingress_controller_port_path" {
  type = object({
    ingress_port     = number
    healt_check_path = string
  })
}

variable "worker_node_role" {
  description = "ARN IAM worker node"
  type        = string
}

variable "cluster_name" {
  description = "Cluster name"
  type        = string
  default     = ""
}

variable "grafana_setting" {
  description = "List of Grafana setting to apply to deployment"
  type = object({
    grafana_version = string
    persistence_enabled = string
    storage_class = string
    storage_size = string
  })
}

variable "grafana_dashboard_list" {
  description =  "Grafana dashboard list to import on EKS"
  type = list(string)
}

variable "grafana_access_credentials" {
  description = "These are the creds set for access to Grafana dashboard"
  type = object({
    username = string
    password = string
  })
}

variable "prometheus_setting" {
  description = "Setting for Prometheus"
  type = object({
    prometheus_version = string
  })
}