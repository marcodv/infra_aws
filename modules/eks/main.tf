/* Usage:
 *
 * Example of 'foo_bar' module in `foo_bar.tf`.
 *
 * - list item 1
 * - list item 2
 *
 * Even inline **formatting** in _here_ is possible.
 * and some [link](https://domain.com/)
 *
 * * list item 3
 * * list item 4
*/

data "aws_caller_identity" "current" {}

# Create EKS cluster 
resource "aws_eks_cluster" "eks_cluster" {
  name     = "eks-${var.environment}-env"
  role_arn = var.eks_cluster_role
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
- rolearn: ${var.eks_cluster_role}
  username: system:node:{{EC2PrivateDNSName}}
  groups:
    - system:bootstrappers
    - system:nodes
    - cluster-full-admin-group
    - cluster-read-only-group
YAML

    mapUsers    = yamlencode(local.k8s_map_users)
    mapAccounts = <<YAML
- ${data.aws_caller_identity.current.account_id}
YAML

  }
}

// Create node group for eks
resource "aws_eks_node_group" "node_group_eks" {
  //ami_type = var.worker_node_ami_id
  depends_on      = [kubernetes_config_map.aws_auth] //, aws_launch_template.eks_launch_group_template]
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "node-group-${var.environment}-env"
  node_role_arn   = aws_eks_cluster.eks_cluster.role_arn
  subnet_ids      = var.eks_subnets
  instance_types  = var.workers_nodes_instance_type

  // Remote access doesn't work with launch template
  remote_access {
    // to rename the ssh keys for workers node
    ec2_ssh_key               = "workers-node-ssh-key-${var.environment}-env"
    source_security_group_ids = [var.eks_sg]
  }

  scaling_config {
    desired_size = var.worker_nodes_scaling_config.desired_size
    max_size     = var.worker_nodes_scaling_config.max_size
    min_size     = var.worker_nodes_scaling_config.min_size
  }

  update_config {
    max_unavailable = var.worker_nodes_update_config.max_unavailable
  }

  //launch_template {
  //  name    = aws_launch_template.eks_launch_group_template.name
  //  version = aws_launch_template.eks_launch_group_template.latest_version
  //} 

}

