output "eks_cluster_role" {
  value = aws_iam_role.iam_role_eks_cluster.arn
}
