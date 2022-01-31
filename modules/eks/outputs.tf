output "eks_endpoint" {
  description = "Return EKS URL API"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_cluster_id" {
  description = "Return cluster's name"
  value       = aws_eks_cluster.eks_cluster.id
}

output "oidc_issuer_url" {
  description = "Return OIDC url issue"
  value       = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}
