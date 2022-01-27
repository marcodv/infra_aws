output "name_http_target_group" {
  description = "Return HTTP target group name for ALB"
  value       = aws_alb_target_group.http_tg_alb.name
}

output "arn_http_target_group" {
  description = "Return ARN for HTTP target group"
  value       = aws_alb_target_group.http_tg_alb.arn
}
