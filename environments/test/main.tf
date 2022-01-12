terraform {
  backend "s3" {
    bucket         = "terraform-state-test-env"
    key            = "terraform-state-test-env/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "tfStateLockingTestEnv"
  }
}

provider "aws" {
  region = "eu-west-1"
  default_tags {
    tags = {
      Environment = var.environment
    }
  }
}


module "networking" {
  source = "../../modules/vpc/"

  environment                    = var.environment
  vpc_cidr_block                 = var.vpc_cidr_block
  public_subnets_cidr            = var.public_subnets_cidr
  private_subnets_cidr           = var.private_subnets_cidr
  availability_zones             = var.availability_zones
  alb_ingress_rule               = var.alb_ingress_rule
  bastion_ingress_rule           = var.bastion_ingress_rule
  private_instances_ingress_rule = var.private_instances_ingress_rule
  bastions-ami                   = var.bastions-ami
  acl_public_subnet_rule         = var.acl_public_subnet_rule
  acl_private_subnet_rule        = var.acl_private_subnet_rule
  acl_db_rule                    = var.acl_db_rule
}

module "lb" {
  source = "../../modules/alb"

  environment       = var.environment
  public_subnet_alb = module.networking.public_subnets_id
  sg_alb            = module.networking.alb_sg
  vpc_id            = module.networking.vpc_id
}

module "db" {

  source = "../../modules/database"

  environment        = var.environment
  azs                = var.availability_zones
  db_subnets         = module.networking.private_subnets_id
  db_sg              = module.networking.db_sg
  vpc_id             = module.networking.vpc_id
  db_master_password = var.db_master_password
  db_master_username = var.db_master_username
}
