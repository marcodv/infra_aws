variable "environment" {
  description = "Environments that we want to deploy"
  type        = string
}

variable "eks_subnets" {
  description = "Subnets where deploy EKS"
  type        = list(string)
}

variable "eks_sg" {
  description = "Security group associate to EKS nodes"
  type        = string
}

variable "vpc_id" {
  description = "VPC id where deploy EKS"
  type        = string
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

variable "worker_node_role" {
  description = "ARN IAM worker node"
  type        = string
}


variable "eks_logs_type" {
  description = "List of logs types enabled on the EKS"
  type        = list(string)
}