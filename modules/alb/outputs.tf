output "target_group_http_id_alb" {
  value = aws_alb_target_group.tg-alb.name
}

output "target_group_port8000_id_alb" {
  value = aws_alb_target_group.tg-port8000.name
}