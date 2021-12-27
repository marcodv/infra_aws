resource "aws_s3_bucket" "test_bucket" {
  bucket        = var.bucketName
  acl           = "private"
  force_destroy = true
}