/* 
 * The file in the Prod folder of this project, allow you to create infra for Prod env
 *
 * Dev and Prod env are equals in terms of resources created.
 *
 * The only differences are for the VPC IP range and tags applied to all the resources
 *
 * If you want to change any of the values for the resources created here,  
 *
 * you need to edit prod.tfvars
 *
 *
*/

terraform {
  backend "s3" {
    bucket         = "terraform-state-prod-env"
    key            = "terraform-state-prod-env/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "tfStateLockingProdEnv"
  }
}

provider "aws" {
  region = "eu-west-1"
  default_tags {
    tags = {
      Environment   = var.environment
      Type_Resource = var.type_resource
    }
  }
}

module "networking" {
  source = "../../modules/vpc/"

  environment                    = var.environment
  vpc_cidr_block                 = var.vpc_cidr_block
  public_subnets_cidr            = var.public_subnets_cidr
  private_subnets_cidr           = var.private_subnets_cidr
  availability_zones             = var.availability_zones
  alb_ingress_rule               = var.alb_ingress_rule
  eks_ingress_rule               = var.eks_ingress_rule
  bastion_ingress_rule           = var.bastion_ingress_rule
  private_instances_ingress_rule = var.private_instances_ingress_rule
  acl_public_subnet_rule         = var.acl_public_subnet_rule
  acl_private_subnet_rule        = var.acl_private_subnet_rule
  sg_db_rule                     = var.sg_db_rule
  acl_db_rule                    = var.acl_db_rule
  db_subnets_cidr                = var.db_private_subnets_cidr
}

module "jump_host" {
  source = "../../modules/bastions"

  environment        = var.environment
  bastions-ami       = var.bastions-ami
  availability_zones = var.availability_zones
  public_subnets_id  = module.networking.public_subnets_id
  bastions_sg        = [module.networking.bastions_sg, module.networking.eks_sg]
}

module "k8s" {
  source = "../../modules/eks"

  environment                 = var.environment
  vpc_id                      = var.vpc_id
  map_cluster_admin_users     = var.map_cluster_admin_users
  namespaces                  = var.namespaces
  read_only_eks_users         = var.read_only_eks_users
  cluster_admin_permissions   = var.cluster_admin_permissions
  read_only_user_permissions  = var.read_only_user_permissions
  workers_nodes_instance_type = var.workers_nodes_instance_type
  worker_nodes_scaling_config = var.worker_nodes_scaling_config
  worker_nodes_update_config  = var.worker_nodes_update_config
  eks_version                 = var.eks_version
  worker_node_role            = var.worker_node_role
  eks_sg                      = module.networking.eks_sg
  eks_subnets                 = module.networking.private_subnets_id
}

module "observability" {
  source = "../../modules/monitoring"

  cluster_name               = module.k8s.eks_cluster_id
  grafana_setting            = var.grafana_setting
  environment                = var.environment
  grafana_dashboard_list     = var.grafana_dashboard_list
  grafana_access_credentials = var.grafana_access_credentials
  prometheus_setting         = var.prometheus_setting
}

module "db" {
  source = "../../modules/database"

  environment        = var.environment
  azs                = var.availability_zones
  db_master_password = var.db_master_password
  db_master_username = var.db_master_username
  db_subnets         = module.networking.db_private_subnets_id
  db_sg              = module.networking.db_sg
  vpc_id             = module.networking.vpc_id
}

module "elastic_cache" {
  source     = "../../modules/elasticache"
  depends_on = [module.networking.vpc_id]

  environment         = var.environment
  elasticache_setting = var.elasticache_setting
  subnet_group_name   = element(module.networking.db_private_subnets_id, 0)
  security_group_ids  = [module.networking.db_sg]
  redis_credentials   = var.redis_credentials
}
