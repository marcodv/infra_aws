/* DB parameter group*/
resource "aws_db_parameter_group" "pg_db" {
  name   = "parameters-group-postgres"
  family = "postgres13"

  //This is a workaround to TF issue https://github.com/hashicorp/terraform-provider-aws/issues/6448
  lifecycle {
    create_before_destroy = true
  }

  parameter {
    apply_method = "immediate"
    name         = "autovacuum"
    value        = "1"
  }

  parameter {
    apply_method = "pending-reboot"
    name         = "autovacuum_max_workers"
    value        = "15"
  }

}

/* DB group name */
resource "aws_db_subnet_group" "subnet_group_name" {
  name       = "${var.environment} environment db private subnets"
  subnet_ids = var.db_subnets
}

/* DB single or master slave*/
resource "aws_db_instance" "db" {
  depends_on             = [aws_db_parameter_group.pg_db, aws_db_subnet_group.subnet_group_name]
  identifier             = "db-${var.environment}-environment"
  allocated_storage      = 10
  engine                 = "postgres"
  engine_version         = "13.3"
  instance_class         = "db.t4g.micro"
  name                   = "mydb2" // change db name to something else
  username               = var.db_master_username
  password               = var.db_master_password
  parameter_group_name   = aws_db_parameter_group.pg_db.name
  skip_final_snapshot    = true
  port                   = 5432
  availability_zone      = var.azs[0]
  db_subnet_group_name   = aws_db_subnet_group.subnet_group_name.name
  vpc_security_group_ids = [var.db_sg]

  tags = {
    Name = "db-${var.environment}-environment"
  }
}
