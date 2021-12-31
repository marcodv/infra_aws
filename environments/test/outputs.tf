output "test_env_vpc_id" {
  value = module.networking.vpc_id
}

output "test_env_vpc_cidr_block" {
  value = module.networking.cidr_block
}

output "test_env_public_subnets_cidr" {
  value = module.networking.public_subnets_cidr
}

output "test_env_public_subnets_id" {
  value = module.networking.test_env_public_subnets_id
}

output "test_env_private_subnets_cidr" {
  value = module.networking.private_subnets_cidr
}

output "test_env_private_subnets_id" {
  value = module.networking.test_env_private_subnets_id
}

output "test_env_azs_public_subnet" {
  value = module.networking.azs_public_subnet
}

output "test_env_azs_private_subnet" {
  value = module.networking.azs_private_subnet
}

output "vpc_sg" {
  value = module.networking.vpc_sg
}

output "alb_sg" {
  value = module.networking.alb_sg
}

output "target-group" {
  value = module.lb.target_group_id_alb
}
