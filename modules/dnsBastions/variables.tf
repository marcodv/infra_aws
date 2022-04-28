variable "environment" {
  description = "Environment where we want to deploy"
  type        = string
}

variable "zone_id" {
  description = "Zone ID where to create DNS record"
  type        = string
}
