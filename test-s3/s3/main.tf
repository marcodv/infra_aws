provider "aws" {
  region = "eu-west-1"
}

resource "aws_s3_bucket" "bucket" {
  count  = length(var.bucket_name)
  bucket = "${var.bucket_name[count.index]}-${var.environment}-${var.region}"
  acl    = "private"

  versioning {
    enabled = true
  }

  tags = {
    Environment = "${var.environment}"
    region      = "${var.region}"
  }
}

resource "aws_s3_bucket_public_access_block" "bucketacl" {
  count  = length(var.bucket_name)
  bucket = "${var.bucket_name[count.index]}-${var.environment}-${var.region}"

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}
