output "vpc_id" {
  description = "Return vpc id"
  value       = module.networking.vpc_id
}

output "vpc_cidr_block" {
  description = "Return vpc cidr block"
  value       = module.networking.cidr_block
}

output "public_subnets_cidr" {
  description = "Return the public subnets cidr"
  value       = module.networking.public_subnets_cidr
}

output "public_subnets_id" {
  description = "Return the public subnets id"
  value       = module.networking.public_subnets_id
}

output "private_subnets_cidr" {
  description = "Return the private subnets cidr"
  value       = module.networking.private_subnets_cidr
}

output "private_subnets_id" {
  description = "Return the private subnets id"
  value       = module.networking.private_subnets_id
}

output "db_subnets_id" {
  description = "Return db subnets id"
  value       = module.networking.db_private_subnets_id
}

output "db_subnets_cidr" {
  description = "Return db subnets cidr blocks"
  value       = module.networking.db_private_subnets_cidr
}

output "azs" {
  description = "Return the availability zones used"
  value       = module.networking.azs_public_subnet
}

output "alb_sg" {
  description = "Return the alb security group"
  value       = module.networking.alb_sg
}

output "db_sg" {
  description = "Return the db security group"
  value       = module.networking.db_sg
}

output "eks_subnets" {
  description = "Return the eks subnets"
  value       = module.networking.private_subnets_id
}

output "bastions_sg" {
  description = "Return the bastions security group"
  value       = module.networking.bastions_sg
}

output "eks_sg" {
  description = "Return eks security group"
  value       = module.networking.eks_sg
}

output "http_target_group" {
  description = "Return HTTP target group from ALB"
  value       = module.lb.name_http_target_group
}

output "arn_http_target_group" {
  description = "Return ARN for HTTP target groups"
  value       = module.lb.arn_http_target_group
}

/*output "db-endpoint" {
  description = "Return db endpoint"
  value = module.db.db-endpoint
} */

output "eks_endpoint" {
  description = "Return EKS URL API"
  value       = module.k8s.eks_endpoint
}

output "eks_cluster_id" {
  description = "Return cluster's name"
  value       = module.k8s.eks_cluster_id
}

output "oidc_issuer_url" {
  description = "Return the OIDC url issue"
  value       = module.k8s.oidc_issuer_url
}
