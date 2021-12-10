provider "aws" {
  profile                 = "test"
  shared_credentials_file = "/Users/marcodivincenzo/.aws/credentials"
  region                  = "eu-west-1"
}

resource "aws_s3_bucket" "bucket" {
  count  = length(var.bucket_name)
  bucket = "${var.bucket_name[count.index]}-${var.environment}-${var.aws_region}"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Environment = "${var.environment}"
    region      = "${var.aws_region}"
  }
}

resource "aws_s3_bucket_public_access_block" "bucketacl" {
  count  = length(var.bucket_name)
  bucket = "${var.bucket_name[count.index]}-${var.environment}-${var.aws_region}"

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}
