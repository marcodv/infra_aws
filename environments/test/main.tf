terraform {
  backend "s3" {
    bucket         = "terraform-state-test-env"
    key            = "terraform-state-test-env/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "tfStateLockingTestEnv"
  }
}

module "networking" {
  source = "../../modules/vpc/"

  environment = var.environment
}