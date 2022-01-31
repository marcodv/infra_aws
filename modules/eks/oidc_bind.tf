
data "tls_certificate" "eks_cluster" {
  depends_on = [aws_eks_cluster.eks_cluster]
  url        = aws_eks_cluster.eks_cluster.identity.0.oidc.0.issuer
}

resource "aws_iam_openid_connect_provider" "oidc_to_cluster" {
  depends_on = [aws_eks_cluster.eks_cluster]
  url        = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer

  client_id_list = ["${replace(aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer, "https://", "")}:sub"]

  thumbprint_list = [data.tls_certificate.eks_cluster.certificates.0.sha1_fingerprint]
}

// Create Role with OIDC values
resource "aws_iam_role" "alb_ingress_role" {
  depends_on = [aws_iam_openid_connect_provider.oidc_to_cluster]
  name        = "alb-ingress-role-${var.environment}-env"
  description = "Role for ALB Ingress Controller"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "arn:aws:iam::848481299679:oidc-provider/${element(aws_iam_openid_connect_provider.oidc_to_cluster.client_id_list, 0)}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${element(aws_iam_openid_connect_provider.oidc_to_cluster.client_id_list, 0)}:sub" : "system:serviceaccount:kube-system:aws-load-balancer-controller"
          }
        }
      }
    ]
  })
}

// This block attach AWS ALB policies to the alb ingress controller role
resource "aws_iam_role_policy_attachment" "alb_ingress_policy" {
  depends_on = [aws_iam_role.alb_ingress_role]
  policy_arn = "arn:aws:iam::848481299679:policy/AWSLoadBalancerControllerIAMPolicy${var.environment}Env"
  role       = "alb-ingress-role-${var.environment}-env"
}
