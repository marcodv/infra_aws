variable "environment" {
  type        = string
  description = "This holds environment name. Example: qa, stage, prod"
}
variable "aws_region" {
  type        = string
  description = "This is the region we use in AWS"
  default     = "eu-west-1"
}
