terraform {
  backend "s3" {
    bucket         = "${var.bucket}"
    key            = "${var.key}"
    region         = "eu-west-1"
    dynamodb_table = "${var.dynamodb_table}"
  }
}

module "test-s3" {
  source ="./test-s3/s3"
}
