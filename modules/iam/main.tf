# IAM role for EKS to make calls to other AWS services
resource "aws_iam_role" "iam_role_eks_cluster" {
  name               = "eks-role-${var.environment}-env"
  assume_role_policy = file("${path.module}/EksClusterRolePolicy.json")
}

# Optionally, enable Security Groups for Pods
# Reference: https://docs.aws.amazon.com/eks/latest/userguide/security-groups-for-pods.html

// This block attach CUSTOMER created policies to the cluster role
resource "aws_iam_role_policy_attachment" "aws_customer_policies_attachment_eks" {
  depends_on = [aws_iam_role.iam_role_eks_cluster]
  count      = length(var.iam_customer_eks_policies)
  role       = aws_iam_role.iam_role_eks_cluster.name
  policy_arn = "arn:aws:iam::848481299679:policy/${element(var.iam_customer_eks_policies, count.index)}"
}

// This block attach AWS policies to the cluster role
resource "aws_iam_role_policy_attachment" "aws_managed_policies_attachment_eks" {
  depends_on = [aws_iam_role.iam_role_eks_cluster]
  count      = length(var.iam_aws_eks_policies)
  policy_arn = "arn:aws:iam::aws:policy/${element(var.iam_aws_eks_policies, count.index)}"
  role       = aws_iam_role.iam_role_eks_cluster.name
}
