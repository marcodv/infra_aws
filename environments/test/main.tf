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
}

module "networking" {
  source = "../../modules/vpc/"

  environment          = var.environment
  cidr_block           = var.cidr_block
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  availability_zones   = var.availability_zones
}

module "lb" {
  source = "../../modules/alb"

  environment       = var.environment
  public_subnet_alb = module.networking.test_env_public_subnets_id
  sg_alb            = module.networking.alb_sg
  vpc_id            = module.networking.vpc_id
}
