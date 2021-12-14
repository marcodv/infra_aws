terraform {
  backend "s3" {
    bucket         = "tfstate-infra-test"
    key            = "terraform_state/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "stateLockingTf"
  }
}