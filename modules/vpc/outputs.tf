output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "cidr_block" {
  value = aws_vpc.vpc.cidr_block
}

output "public_subnets_cidr" {
  value = [for s in aws_subnet.public_subnet : s.cidr_block]
}

output "public_subnets_id" {
  value = [for ids in aws_subnet.public_subnet : ids.id]
}

output "azs_public_subnet" {
  value = [for az in aws_subnet.public_subnet : az.availability_zone]
}

output "private_subnets_cidr" {
  value = [for s in aws_subnet.private_subnet : s.cidr_block]
}

output "private_subnets_id" {
  value = [for ids in aws_subnet.private_subnet : ids.id]
}

output "db_private_subnets_id" {
  value = [for ids in aws_subnet.db_subnets : ids.id]
}

output "db_private_subnets_cidr" {
  value = [for s in aws_subnet.db_subnets : s.cidr_block]
}

output "alb_sg" {
  value = aws_security_group.alb_sg.id
}

output "db_sg" {
  value = aws_security_group.db_sg.id
}

output "eks_sg" {
  value = aws_security_group.eks_sg.id
}

output "bastions_sg" {
  value = aws_security_group.bastions_sg.id
}
