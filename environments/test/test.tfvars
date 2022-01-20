environment                    = "test"
bastions-ami                   = "ami-04dd4500af104442f"
vpc_cidr_block                 = "10.0.0.0/16"
public_subnets_cidr            = ["10.0.0.0/20", "10.0.16.0/20"]  //, "10.0.32.0/20"]
private_subnets_cidr           = ["10.0.48.0/20", "10.0.64.0/20"] //, "10.0.80.0/20"]
db_private_subnets_cidr        = ["10.0.96.0/20", "10.0.112.0/20"]
availability_zones             = ["eu-west-1a", "eu-west-1b"] //, "eu-west-1c"]
alb_ingress_rule               = [80, 443, 8000, 8080]
bastion_ingress_rule           = [22, 80, 443, 8080]
private_instances_ingress_rule = [22, 80, 8000, 8080]
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
      rule_no   = 104
      from_port = 8000
      to_port   = 8000
    },
    {
      rule_no   = 105
      from_port = 8080
      to_port   = 8080
    },
    {
      rule_no   = 200
      from_port = 1024
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
      rule_no   = 104
      from_port = 8000
      to_port   = 8000
    },
    {
      rule_no   = 105
      from_port = 8080
      to_port   = 8080
    },
    {
      rule_no   = 200
      from_port = 1024
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
  }

]

read_only_eks_dashboard = {
  users = [/*{
    userarn  = "arn:aws:iam::848481299679:user/bastiaan@noah.energy"
    username = "bastiaan@noah.energy"
    groups   = ["eks-dashboard-limited-access-clusterrole"]
  }*/]
}

map_cluster_admin_users = {
  admins = [{
    userarn  = "arn:aws:iam::848481299679:user/bastiaan@noah.energy"
    username = "bastiaan@noah.energy"
    groups   = ["system:masters", "eks-console-dashboard-full-access-group"]
    },
    {
      userarn  = "arn:aws:iam::848481299679:user/marco@noah.energy"
      username = "marco@noah.energy"
      groups   = ["system:masters", "eks-console-dashboard-full-access-group"]
  }]
}
