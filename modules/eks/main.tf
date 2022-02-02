/* 
 * This module is used to deploy EKS with instance managed by a worker node group
 * 
 * These are the resources created in this module 
 *
 * - EKS cluster
 * - Cluster full admin/read only users mapped in the aws_auth configMap
 * - Node Group
 *
 *
*/


data "aws_caller_identity" "current" {}

# Create EKS cluster 
resource "aws_eks_cluster" "eks_cluster" {
  name     = "eks-${var.environment}-env"
  role_arn = "arn:aws:iam::848481299679:role/eks-role-${var.environment}-env"
  version  = var.eks_version

  vpc_config {
    security_group_ids     = [var.eks_sg]
    subnet_ids             = var.eks_subnets
    endpoint_public_access = true
    //endpoint_private_access = true
  }

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

}

// This create a map object with admin and read only users
// to be added to aws_auth configMap
locals {
  k8s_admins = [
    for user in var.map_cluster_admin_users.admins :
    {
      userarn  = user.userarn
      username = user.username
      groups   = user.groups
    }
  ]
  eks_read_only_dashboard_users = [
    for user in var.read_only_eks_users.users :
    {
      userarn  = user.userarn
      username = user.username
      groups   = user.groups
    }
  ]

  k8s_map_users = concat(local.k8s_admins, local.eks_read_only_dashboard_users)
}

// Create accounts in aws_auth configMap
resource "kubernetes_config_map" "aws_auth" {
  depends_on = [aws_eks_cluster.eks_cluster]
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = <<YAML
- rolearn: "${var.worker_node_role}"
  username: system:node:{{EC2PrivateDNSName}}
  groups:
    - system:bootstrappers
    - system:nodes
YAML

    mapUsers    = yamlencode(local.k8s_map_users)
    mapAccounts = <<YAML
- ${data.aws_caller_identity.current.account_id}
YAML

  }
}

// Create node group for eks
resource "aws_eks_node_group" "node_group_eks" {
  depends_on      = [kubernetes_config_map.aws_auth] 
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "node-group-${var.environment}-env"
  node_role_arn   = var.worker_node_role
  subnet_ids      = var.eks_subnets
  instance_types  = var.workers_nodes_instance_type

  remote_access {
    ec2_ssh_key               = "workers-node-ssh-key-${var.environment}-env"
    source_security_group_ids = [var.eks_sg]
  }

  // Scaling configuration
  scaling_config {
    desired_size = var.worker_nodes_scaling_config.desired_size
    max_size     = var.worker_nodes_scaling_config.max_size
    min_size     = var.worker_nodes_scaling_config.min_size
  }

  update_config {
    max_unavailable = var.worker_nodes_update_config.max_unavailable
  }

  // This tag tell to the EC2 worker node to join to the cluster
  tags = {
    "kubernetes.io/cluster/eks-${var.environment}-env" = "owned"
  }
}

