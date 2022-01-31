// Create ALB ingress controller role 
// Check how to substitute oidc value 
/*resource "aws_iam_role" "alb_ingress_role" {
  name               = "alb-ingress-role-${var.environment}-env"
  description        = "Role for ALB Ingress Controller"
  assume_role_policy = file("${path.module}/AlbIngressRole.json")
}

// TO ADD ROLE WITH OIDC VALUE :(
// This block attach AWS ALB policies to the alb ingress controller role
resource "aws_iam_role_policy_attachment" "alb_ingress_policy" {
  depends_on = [aws_iam_role.alb_ingress_role]
  policy_arn = "arn:aws:iam::848481299679:policy/AWSLoadBalancerControllerIAMPolicy${var.environment}Env"
  role       = aws_iam_role.alb_ingress_role.name
} */
