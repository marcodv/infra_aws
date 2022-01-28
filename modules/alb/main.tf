/*==== ALB ======*/
resource "aws_alb" "alb" {
  name               = "ALB-for-${var.environment}-environment"
  subnets            = var.public_subnet_alb
  security_groups    = [var.sg_alb]
  internal           = false
  load_balancer_type = "application"
  idle_timeout       = "300"

  drop_invalid_header_fields = true
  tags = {
    "kubernetes.io/role/elb"                           = "1"
    "kubernetes.io/cluster/eks-${var.environment}-env" = "owned"
    "ingress.k8s.aws/resource"                         = "LoadBalancer"
    "elbv2.k8s.aws/cluster"                            = "eks-${var.environment}-env"
    // This tag bind existing ALB to traefik ingress
    //"ingress.k8s.aws/stack" = "traefik/traefik-ingress"
  }
}

/*==== Target Group HTTP ======*/
resource "aws_alb_target_group" "http_tg_alb" {
  depends_on = [aws_alb.alb]
  name       = "HTTP-TG-${var.environment}-env"
  port       = 30080
  protocol   = "HTTP"
  vpc_id     = var.vpc_id
  health_check {
    interval            = 30
    path                = "/"
    port                = 30080
    healthy_threshold   = 2
    unhealthy_threshold = 3
    timeout             = 20
    protocol            = "HTTP"
    matcher             = "200,202"
  }

  tags = {
    Resource = "http-target-group"
  }
}

/*==== Listener HTTP ======*/
resource "aws_alb_listener" "http_listener_alb" {
  depends_on        = [aws_alb_target_group.http_tg_alb]
  load_balancer_arn = aws_alb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.http_tg_alb.arn
  }
}

resource "aws_lb_listener_rule" "http_rule" {
  listener_arn = aws_alb_listener.http_listener_alb.arn
  priority = 100

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.http_tg_alb.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }

}
