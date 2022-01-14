# Create EKS cluster 
resource "aws_eks_cluster" "eks_cluster" {
  name = "eks-${var.environment}-env"
  role_arn = var.eks_cluster_role
  version  = "1.21"

  vpc_config {
    security_group_ids      = [var.eks_sg]
    subnet_ids              = var.eks_subnets
    endpoint_public_access  = false
    endpoint_private_access = true
  }
}
