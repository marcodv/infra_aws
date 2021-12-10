resource "aws_s3_bucket" "test-bucket-1" {
  bucket = "test-bucket-1-${var.environment}-${var.aws_region}"
  acl    = "private"
  block_public_acls   = true
  block_public_policy = true

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

resource "aws_s3_bucket" "test-bucket-2" {
  bucket = "test-bucket-2-${var.environment}-${var.aws_region}"
  acl    = "private"
  block_public_acls   = true
  block_public_policy = true

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

resource "aws_s3_bucket" "test-bucket-3" {
  bucket = "test-bucket-3-${var.environment}-${var.aws_region}"
  acl    = "private"
  block_public_acls   = true
  block_public_policy = true
  
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