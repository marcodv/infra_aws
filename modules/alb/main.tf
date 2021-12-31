/*==== ALB Target Group ======*/
resource "aws_lb_target_group" "tg-alb" {
  name     = "TargetGroup-${var.environment}-environment"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    interval            = 70
    path                = "/index.html"
    port                = 80
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 60
    protocol            = "HTTP"
    matcher             = "200,202"
  }

  tags = {
    Environment = "${var.environment}"
    Resource    = "target-group"
  }
}

/*==== ALB ======*/
resource "aws_alb" "alb" {
  depends_on         = [aws_lb_target_group.tg-alb]
  name               = "ALB-for-${var.environment}-environment"
  subnets            = var.public_subnet_alb
  security_groups    = [var.sg_alb]
  internal           = false
  load_balancer_type = "application"
  idle_timeout       = "300"

  tags = {
    Environment = var.environment
  }
}
