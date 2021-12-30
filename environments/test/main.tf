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