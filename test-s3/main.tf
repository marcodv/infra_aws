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

module "bucket_to_create" {
  source = "./s3"

  bucketName = var.bucketName
}
