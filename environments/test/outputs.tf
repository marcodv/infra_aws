output "vpc_id" {
  value = module.networking.vpc_id
}

output "vpc_cidr_block" {
  value = module.networking.cidr_block
}

output "public_subnets_cidr" {
  value = module.networking.public_subnets_cidr
}

output "public_subnets_id" {
  value = module.networking.public_subnets_id
}

output "private_subnets_cidr" {
  value = module.networking.private_subnets_cidr
}

output "private_subnets_id" {
  value = module.networking.private_subnets_id
}

output "db_subnets_id" {
  value = module.networking.db_private_subnets_id
}

output "db_subnets_cidr" {
  value = module.networking.db_private_subnets_cidr
}

output "azs" {
  value = module.networking.azs_public_subnet
}

output "alb_sg" {
  value = module.networking.alb_sg
}

output "db_sg" {
  value = module.networking.db_sg
}

output "eks_subnets" {
  value = module.networking.private_subnets_id
}

output "bastions_sg" {
  value = module.networking.bastions_sg
}

output "eks_sg" {
  value = module.networking.eks_sg
}

output "eks_role" {
  value = module.iam.eks_cluster_role
}

output "target_group" {
  value = module.lb.target_group_http_id_alb
}

/*output "db-endpoint" {
  value = module.db.db-endpoint
} */

output "eks_endpoint" {
  value = module.k8s.eks_endpoint
}

output "eks_cluster_id" {
  value = module.k8s.eks_cluster_id
}