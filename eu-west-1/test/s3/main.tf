resource "aws_s3_bucket" "test-bucket-1" {
  bucket = "test-bucket-1-${var.environment}-${var.aws_region}".id
  acl    = "private"

  versioning {
    enabled = true
  }

  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "log/"
  }

  tags = {
    Environment = "${var.environment}"
    region      = "${var.aws_region}"
  }
}

resource "aws_s3_bucket_public_access_block" "test-bucket-1" {
  bucket = "test-bucket-1-${var.environment}-${var.aws_region}".id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket" "test-bucket-2" {
  bucket = "test-bucket-2-${var.environment}-${var.aws_region}".id
  acl    = "private"

  versioning {
    enabled = true
  }

  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "log/"
  }  

  tags = {
    Environment = "${var.environment}"
    region      = "${var.aws_region}"
  }
}

resource "aws_s3_bucket_public_access_block" "test-bucket-2" {
  bucket = "test-bucket-2-${var.environment}-${var.aws_region}".id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}

resource "aws_s3_bucket" "test-bucket-3" {
  bucket = "test-bucket-3-${var.environment}-${var.aws_region}".id
  acl    = "private"


  versioning {
    enabled = true
  }

  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "log/"
  }

  tags = {
    Environment = "${var.environment}"
    region      = "${var.aws_region}"
  }
}

resource "aws_s3_bucket_public_access_block" "test-bucket-3" {
  bucket = "test-bucket-3-${var.environment}-${var.aws_region}".id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

}