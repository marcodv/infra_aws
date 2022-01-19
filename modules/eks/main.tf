data "aws_iam_group" "admin-members" {
  group_name = "User-manage-eks-cluster"
}

data "aws_caller_identity" "current" {}

# Create EKS cluster 
resource "aws_eks_cluster" "eks_cluster" {
  name     = "eks-${var.environment}-env"
  role_arn = var.eks_cluster_role
  version  = "1.21"

  vpc_config {
    security_group_ids     = [var.eks_sg]
    subnet_ids             = var.eks_subnets
    endpoint_public_access = true
    //endpoint_private_access = true
  }
}

locals {
  k8s_admins = [
    for user in var.map_cluster_admin_users.admins :
    {
      userarn  = user.userarn
      username = user.username
      groups   = user.groups
    }
  ]
  //k8s_map_users = local.k8s_admins

  // The follow group could be used for Tim to have Read-Only access to the cluster

  eks_read_only_dashboard_users = [
    for user in var.read_only_eks_dashboard.users :
    {
      userarn  = user.userarn
      username = user.username
      groups   = user.groups
    }
  ]

  k8s_map_users = concat(local.k8s_admins, local.eks_read_only_dashboard_users)
}



// aws_auth need to be created before create eks node-group
resource "kubernetes_config_map" "aws_auth" {
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
    - eks-console-dashboard-full-access-group
    - eks-dashboard-limited-access-clusterrole
YAML

    mapUsers    = yamlencode(local.k8s_map_users)
    mapAccounts = <<YAML
- ${data.aws_caller_identity.current.account_id}
YAML

  }
}


/*resource "aws_eks_node_group" "node-group-eks" {
  depends_on = [kubernetes_config_map.aws_auth]
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "node-group-${var.environment}-env"
  node_role_arn   = aws_eks_cluster.eks_cluster.role_arn
  subnet_ids      = var.eks_subnets
  instance_types = ["t2.small"]

  remote_access {
    ec2_ssh_key = "bastion-ssh-key-${var.environment}"
    source_security_group_ids = [var.eks_sg]
  }

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.

} */

