output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "cidr_block" {
  value = aws_vpc.vpc.cidr_block
}

output "public_subnets_cidr" {
  value = [for s in aws_subnet.public_subnet : s.cidr_block]
}

output "azs_public_subnet" {
  value = [for az in aws_subnet.public_subnet : az.availability_zone]
}

output "private_subnets_cidr" {
  value = [for s in aws_subnet.private_subnet : s.cidr_block]
}

output "azs_private_subnet" {
  value = [for az in aws_subnet.private_subnet : az.availability_zone]
}