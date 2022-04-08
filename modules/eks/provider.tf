terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "~> 1.13.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.5.1"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.6.0"
    }
  }
}

data "aws_eks_cluster" "cluster" {
  name = aws_eks_cluster.eks_cluster.id
}

data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.eks_cluster.id
}

provider "kubernetes" {
  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", "eks-${var.environment}-env"]
  }
  host                   = aws_eks_cluster.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
}

provider "kubectl" {
  token                  = data.aws_eks_cluster_auth.cluster.token
  host                   = aws_eks_cluster.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  // the following config fix this issue
  //https://github.com/gavinbunney/terraform-provider-kubectl/issues/35
  load_config_file = false
}
