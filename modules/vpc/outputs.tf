output "vpc_id" {
  description = "Return vpc id"
  value       = aws_vpc.vpc.id
}

output "cidr_block" {
  description = "Return vpc cidr block"
  value       = aws_vpc.vpc.cidr_block
}

output "public_subnets_cidr" {
  description = "Return a list of the public subnets cidr"
  value       = [for s in aws_subnet.public_subnet : s.cidr_block]
}

output "public_subnets_id" {
  description = "Return a list of the public subnets id"
  value       = [for ids in aws_subnet.public_subnet : ids.id]
}

output "azs_public_subnet" {
  description = "Return a list of the availability zones used"
  value       = [for az in aws_subnet.public_subnet : az.availability_zone]
}

output "private_subnets_cidr" {
  description = "Return a list of the private subnets cidr"
  value       = [for s in aws_subnet.private_subnet : s.cidr_block]
}

output "private_subnets_id" {
  description = "Return a list of the private subnets id"
  value       = [for ids in aws_subnet.private_subnet : ids.id]
}

output "eks_sg" {
  description = "Return eks security group id"
  value       = aws_security_group.eks_sg.id
}

output "bastions_sg" {
  description = "Return the bastions security group id"
  value       = aws_security_group.bastions_sg.id
}
