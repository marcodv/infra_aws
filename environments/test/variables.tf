variable "environment" {}
variable "cidr_block" {}
variable "public_subnets_cidr" {}
variable "private_subnets_cidr" {}
variable "availability_zones" {}
variable "public_subnet_alb" {
    default = ""
}
variable "sg_alb" {
    default = ""
}
variable "vpc_id" {
  default = ""
}