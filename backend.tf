terraform {
  backend "s3" {
    bucket = "tfstate-infra-test"
    key    = "terraform_state"
    region = "eu-west-1"
  }
}