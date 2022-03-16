variable "environment" {
  description = "Environments that we want to deploy"
  type        = string
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}

variable "db_subnets" {
  description = "List of private subnets for DB"
  type        = list(string)
}

variable "db_sg" {}

variable "vpc_id" {
  description = "VPC id"
  type        = string
}

variable "db_master_password" {}

variable "db_master_username" {}

variable "postgres_prod_secrets" {
  description = "Name for the prod secret stored in AWS"
  type        = string
}

variable "postgres_dev_secrets" {
  description = "Name for the dev secret stored in AWS"
  type        = string
}