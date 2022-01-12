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

output "azs_subnets" {
  value = module.networking.azs_public_subnet
}

output "alb_sg" {
  value = module.networking.alb_sg
}

output "target_group" {
  value = module.lb.target_group_http_id_alb
}

output "db_sg" {
  value = module.networking.db_sg
}

output "rds-endpoint" {
  value = module.db.db-endpoint
}