output "db-endpoint" {
  description = "Return db endpoint"
  value       = aws_db_instance.db.address
}
