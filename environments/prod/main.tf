terraform {
  backend "s3" {
    bucket         = "terraform-state-prod-env"
    key            = "terraform-state-prod-env/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "tfStateLockingProdEnv"
  }
}