environment                    = "prod"
type_resource                  = "destroyable"
bastions-ami                   = "ami-04dd4500af104442f"
vpc_cidr_block                 = "10.0.0.0/16"
public_subnets_cidr            = ["10.0.0.0/20", "10.0.16.0/20"]  //, "10.0.32.0/20"]
private_subnets_cidr           = ["10.0.48.0/20", "10.0.64.0/20"] //, "10.0.80.0/20"]
db_private_subnets_cidr        = ["10.0.96.0/20", "10.0.112.0/20"]
availability_zones             = ["eu-west-1a", "eu-west-1b"] //, "eu-west-1c"]
alb_ingress_rule               = [80, 443]
eks_ingress_rule               = [53, 80, 443]
bastion_ingress_rule           = [22, 80, 443]
private_instances_ingress_rule = [22, 80, 443, 30080]
sg_db_rule                     = [5432]
acl_public_subnet_rule = {
  ingress_rule = [{
    rule_no   = 100
    from_port = 22
    to_port   = 22
    },
    {
      rule_no   = 101
      from_port = 80
      to_port   = 80
    },
    {
      rule_no   = 102
      from_port = 443
      to_port   = 443
    },
    {
      rule_no   = 103
      from_port = 5432
      to_port   = 5432
    },
    {
      rule_no   = 200
      from_port = 1025
      to_port   = 65535
  }]
}

acl_private_subnet_rule = {
  ingress_rule = [{
    rule_no   = 100
    from_port = 22
    to_port   = 22
    },
    {
      rule_no   = 101
      from_port = 80
      to_port   = 80
    },
    {
      rule_no   = 102
      from_port = 443
      to_port   = 443
    },
    {
      rule_no   = 103
      from_port = 5432
      to_port   = 5432
    },
    {
      rule_no   = 106
      from_port = 30080
      to_port   = 30080
    },
    {
      rule_no   = 200
      from_port = 1025
      to_port   = 65535
  }]
}

acl_db_rule = {
  ingress_rule = [{
    rule_no   = 100
    from_port = 5432
    to_port   = 5432
  }]
}

// The next vars are related to eks, node-group, launch config 
namespaces = [
  {
    manage             = "Terraform",
    name               = "staging"
    custom_annotations = [{ label = "staging.io/annotation", value = "staging" }]
    custom_labels      = [{ label = "environment", value = "staging" }]
  },
  {
    manage             = "Terraform",
    name               = "development"
    custom_annotations = [{ label = "development.io/annotation", value = "development" }]
    custom_labels      = [{ label = "environment", value = "development" }]
  },
  {
    manage             = "Terraform",
    name               = "production"
    custom_annotations = [{ label = "production.io/annotation", value = "production" }]
    custom_labels      = [{ label = "environment", value = "production" }]
  },
  {
    manage             = "Terraform",
    name               = "monitoring"
    custom_annotations = [{ label = "service.io/annotation", value = "monitoring" }]
    custom_labels      = [{ label = "service", value = "monitoring" }]
  }
]

cluster_admin_permissions = [
  {
    api_groups = [""]
    resources  = ["nodes", "namespaces", "pods"]
    verbs      = ["get", "list", "watch", "describe"]
  },
  {
    api_groups = ["apps"]
    resources  = ["deployments", "daemonsets", "replicasets", "statefulsets"]
    verbs      = ["get", "list", "watch", "describe"]
  },
  {
    api_groups = ["batch"]
    resources  = ["cronjobs", "jobs"]
    verbs      = ["get", "list", "watch", "describe"]
  }
]

read_only_user_permissions = [
  {
    api_groups = [""]
    resources  = ["nodes", "namespaces"]
    verbs      = ["get", "list"]
  },
  {
    api_groups = ["apps"]
    resources  = ["deployments", "daemonsets", "replicasets", "statefulsets"]
    verbs      = ["get", "list"]
  },
  {
    api_groups = ["batch"]
    resources  = ["jobs"]
    verbs      = ["get", "list"]
  }
]

read_only_eks_users = {
  users = [/*{
    userarn  = "arn:aws:iam::848481299679:user/username@noah.energy"
    username = "username@noah.energy"
    groups   = ["cluster-read-only-group"]
  }*/]
}

map_cluster_admin_users = {
  admins = [
    {
      userarn  = "arn:aws:iam::848481299679:user/bastiaan@noah.energy"
      username = "bastiaan@noah.energy"
      groups   = ["system:masters", "cluster-full-admin-group"]
    },
    {
      userarn  = "arn:aws:iam::848481299679:user/marco@noah.energy"
      username = "marco@noah.energy"
      groups   = ["system:masters", "cluster-full-admin-group"]
    },
    {
      userarn  = "arn:aws:iam::848481299679:user/Terraform_User_Prod_Env"
      username = "Terraform_User_Prod_Env@noah.energy"
      groups   = ["system:masters", "cluster-full-admin-group"]
  }
  ]
}

workers_nodes_instance_type = ["t2.medium"]

worker_nodes_scaling_config = {
  desired_size = 1
  max_size     = 2
  min_size     = 1
}

worker_nodes_update_config = {
  max_unavailable = 1
}

eks_version = 1.21

// EKS ALB ingress controller definition
eks_ingress_controller_port_path = {
  ingress_port     = 30080
  healt_check_path = "/"
}

worker_node_role = "arn:aws:iam::848481299679:role/WorkerNodeRoleprodEnv"
