output "eks_cluster_role" {
  description = "Return ARN EKS cluster role"
  value       = aws_iam_role.iam_role_eks_cluster.arn
}
