resource "aws_s3_bucket" "test-bucket-1" {
  bucket = "test-bucket-1-${var.environment}-${var.aws_region}"
  acl    = "public"

  tags = {
    Environment = "${var.environment}"
    region      = ${var.aws_region}
  }
}
resource "aws_s3_bucket" "test-bucket-2" {
  bucket = "test-bucket-2-${var.environment}-${var.aws_region}"
  acl    = "public"

  tags = {
    Environment = "${var.environment}"
    region      = "${var.aws_region}"
  }
}

resource "aws_s3_bucket" "test-bucket-3" {
  bucket = "test-bucket-3-${var.environment}-${var.aws_region}"
  acl    = "public"

  tags = {
    Environment = "${var.environment}"
    region      = "${var.aws_region}"
  }
}