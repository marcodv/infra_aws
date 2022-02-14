/* 
 * This module is used to deploy a SINGLE Postgres DB version 13 in one of the 2 Private AZ.
 *
 * Also created a parameter group which defined the parameters that
 * we need to update or change 
 * 
 * The DB creation depend from the db parameters group and also the private subnets.
 *
 * DB passwd and username are stored in [GitLab group variables section](https://gitlab.com/groups/noah-energy/-/settings/ci_cd) 
 *
 * DB credentials are passed to Terraform at pipeline execution time 
 *
 * The DB created have these configurations:
 *
 * - 10GB of storage 
 * - Tagged by AZ and environment
 * - Port open: 5432
 *
*/

/* DB parameter group*/
resource "aws_db_parameter_group" "pg_db" {
  name   = "parameters-group-postgres-${var.environment}-env"
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
  db_name                = "backend${var.environment}env"
  username               = var.db_master_username
  password               = var.db_master_password
  parameter_group_name   = aws_db_parameter_group.pg_db.name
  skip_final_snapshot    = true
  port                   = 5432
  availability_zone      = var.azs[0] // change this to have a db for each subnet
  db_subnet_group_name   = aws_db_subnet_group.subnet_group_name.name
  vpc_security_group_ids = [var.db_sg]

  tags = {
    Name = "db-${var.environment}-environment"
  }
}
