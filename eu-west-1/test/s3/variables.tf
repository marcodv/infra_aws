variable "environment" {
  type        = string
  description = "This holds environment name. Example: test, prod"
  default     = "test"
}
variable "aws_region" {
  type        = string
  description = "This is the region we use in AWS. Default is eu-west-1"
  default     = "eu-west-1"
}

variable "bucket_name" {
  description = "list of the buckets name"
  type        = list(string)
  default     = ["test-1", "test-2", "test-3"]
}