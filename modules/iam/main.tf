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
   },
  {
   "Effect": "Allow",
   "Principal": {
    "Service": "ec2.amazonaws.com"
   },
    "Action": "sts:AssumeRole"
   }
  ]
 }
POLICY
}

# Create Full Access Policy for EKS
resource "aws_iam_policy" "eks_all_access_policy" {
  name   = "EksAllAccessPolicy"
  path   = "/"
  policy = file("${path.module}/EksAllAccess.json")
}

# Attaching Full Access Policy for EKS to ekscluster role.
resource "aws_iam_role_policy_attachment" "eks_all_access" {
  depends_on = [aws_iam_role.iam_role_eks_cluster]
  policy_arn = aws_iam_policy.eks_all_access_policy.arn
  role       = aws_iam_role.iam_role_eks_cluster.name
} 

# Create EC2 Full Access Policy for EKS
resource "aws_iam_policy" "ec2_all_access_policy" {
  name   = "EC2FullAccessPolicy"
  path   = "/"
  policy = file("${path.module}/AmazonEC2FullAccess.json")
}

# Attaching EC2 Full Access Policy for EKS to ekscluster role.
resource "aws_iam_role_policy_attachment" "ec2_all_access" {
  depends_on = [aws_iam_role.iam_role_eks_cluster]
  policy_arn = aws_iam_policy.ec2_all_access_policy.arn
  role       = aws_iam_role.iam_role_eks_cluster.name
}

# Create IAM Limited Access Policy for EKS
resource "aws_iam_policy" "iam_limited_access_policy" {
  name   = "IAMLimitedAccessPolicy"
  path   = "/"
  policy = file("${path.module}/IamLimitedAccess.json")
}

# Attaching IAM Limited Access Policy for EKS ekscluster role.
resource "aws_iam_role_policy_attachment" "iam_limited_access" {
  depends_on = [aws_iam_role.iam_role_eks_cluster]
  policy_arn = aws_iam_policy.iam_limited_access_policy.arn
  role       = aws_iam_role.iam_role_eks_cluster.name
}

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

resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSWorkerNodePolicy" {
  depends_on = [aws_iam_role.iam_role_eks_cluster]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.iam_role_eks_cluster.name
}

resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKS_CNI_Policy" {
  depends_on = [aws_iam_role.iam_role_eks_cluster]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.iam_role_eks_cluster.name
}

resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEC2ContainerRegistryReadOnly" {
  depends_on = [aws_iam_role.iam_role_eks_cluster]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.iam_role_eks_cluster.name
}
