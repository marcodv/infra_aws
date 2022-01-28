
/*data "tls_certificate" "eks_cluster" {
  depends_on = [aws_eks_cluster.eks_cluster]
  url        = aws_eks_cluster.eks_cluster.identity.0.oidc.0.issuer
}

resource "aws_iam_openid_connect_provider" "oidc_to_cluster" {
  depends_on = [aws_eks_cluster.eks_cluster]
  url        = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer

  client_id_list = ["${replace(aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer, "https://", "")}:sub"]

  thumbprint_list = [data.tls_certificate.eks_cluster.certificates.0.sha1_fingerprint]
} */
