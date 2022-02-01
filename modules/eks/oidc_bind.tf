
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

// https://stackoverflow.com/questions/65934606/what-does-eksctl-create-iamserviceaccount-do-under-the-hood-on-an-eks-cluster


// Create Role with OIDC values
 /*resource "aws_iam_role" "alb_ingress_role" {
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
            "${replace(aws_iam_openid_connect_provider.oidc_to_cluster.url, "https://", "")}:sub": "system:serviceaccount:kube-system:alb-ingress-role-${var.environment}-env"
            "${replace(aws_iam_openid_connect_provider.oidc_to_cluster.url, "https://", "")}:aud": "sts.amazonaws.com"
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



// This block attach AWS OIDC policies to the cluster role
resource "aws_iam_role_policy_attachment" "cluster_role_policy" {
  depends_on = [aws_iam_policy.oidc_cluster_policy]
  //policy_arn = "arn:aws:iam::848481299679:policy/AWSLoadBalancerControllerIAMPolicy${var.environment}Env"
  policy_arn = "${aws_iam_policy.oidc_cluster_policy.name}"
  role       = "eks-role-${var.environment}-env"
} */