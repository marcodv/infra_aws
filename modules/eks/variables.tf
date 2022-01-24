variable "environment" {}

variable "eks_subnets" {}

variable "eks_sg" {}

variable "vpc_id" {}

variable "eks_cluster_role" {}

variable "map_cluster_admin_users" {}

variable "read_only_eks_users" {}

variable "namespaces" {}

variable "cluster_admin_permissions" {}

variable "read_only_user_permissions" {}

variable "workers_nodes_instance_type" {}

variable "worker_nodes_scaling_config" {}

variable "worker_nodes_update_config" {}

variable "worker_node_ami_id" {}

variable "eks_version" {}