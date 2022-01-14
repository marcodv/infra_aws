# IAM role for EKS to make calls to other AWS services
resource "aws_iam_role" "iam_role_eks_cluster" {
  name               = "eks-role-${var.environment}-env"
  assume_role_policy = <<POLICY
{
 "Version": "2012-10-17",
 "Statement": [
   {
   "Effect": "Allow",
   "Principal": {
    "Service": "eks.amazonaws.com"
   },
   "Action": "sts:AssumeRole"
   }
  ]
 }
POLICY
}

# IAM Policy for EKS
/*resource "aws_iam_policy" "eks_policy" {
  name        = "BasicEKSPolicy"
  path        = "/"
  description = "This policy meet the bare minium requirements"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "iam:AttachRolePolicy",
          "iam:CreateRole",
          "iam:TagRole",
          "iam:GetRole",
          "iam:ListRolePolicies",
          "iam:ListAttachedRolePolicies",
          "iam:ListInstanceProfilesForRole",
          "iam:PassRole"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
} */

# Attaching the previous policy 
/*resource "aws_iam_role_policy_attachment" "eks_cluster_minimum_policy" {
  depends_on = [aws_iam_role.iam_role_eks_cluster, aws_iam_policy.eks_policy]
  policy_arn = aws_iam_policy.eks_policy.arn
  role       = aws_iam_role.iam_role_eks_cluster.name
} */

# Attaching EKS-Cluster policies to the terraformekscluster role.
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  depends_on = [aws_iam_role.iam_role_eks_cluster]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.iam_role_eks_cluster.name
}

# Optionally, enable Security Groups for Pods
# Reference: https://docs.aws.amazon.com/eks/latest/userguide/security-groups-for-pods.html
resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSVPCResourceController" {
  depends_on = [aws_iam_role.iam_role_eks_cluster]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.iam_role_eks_cluster.name
}

