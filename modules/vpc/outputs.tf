output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "cidr_block" {
  value = aws_vpc.vpc.cidr_block
}

output "public_subnets_cidr" {
  value = [for s in aws_subnet.public_subnet : s.cidr_block]
}

output "test_env_public_subnets_id" {
  value = [for ids in aws_subnet.public_subnet : ids.id]
}

output "azs_public_subnet" {
  value = [for az in aws_subnet.public_subnet : az.availability_zone]
}

output "private_subnets_cidr" {
  value = [for s in aws_subnet.private_subnet : s.cidr_block]
}

output "test_env_private_subnets_id" {
  value = [for ids in aws_subnet.private_subnet : ids.id]
}

output "azs_private_subnet" {
  value = [for az in aws_subnet.private_subnet : az.availability_zone]
}

output "vpc_sg" {
  value = aws_security_group.vpc_sg.id
}

output "alb_sg" {
  value = aws_security_group.alb_sg.id
}