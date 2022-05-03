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

/*
module "jump_host" {
  source = "../../modules/bastions"

  environment        = var.environment
  //bastions-ami       = var.bastions-ami
  availability_zones = var.availability_zones
}

module "k8s" {
  source = "../../modules/eks"

  environment                 = var.environment
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
  eks_logs_type               = var.eks_logs_type
}

/*
module "bastionDnsEntries" {
  depends_on = [module.jump_host]
  source = "../../modules/dnsBastions"

  environment                 = var.environment
  zone_id = var.zone_id
} */