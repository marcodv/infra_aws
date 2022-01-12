environment                    = "test"
bastions-ami                   = "ami-04dd4500af104442f"
vpc_cidr_block                 = "10.0.0.0/16"
public_subnets_cidr            = ["10.0.0.0/20", "10.0.16.0/20"]  //, "10.0.32.0/20"]
private_subnets_cidr           = ["10.0.48.0/20", "10.0.64.0/20"] //, "10.0.80.0/20"]
availability_zones             = ["eu-west-1a", "eu-west-1b"]     //, "eu-west-1c"]
alb_ingress_rule               = [80, 443, 8000]
bastion_ingress_rule           = [22, 80, 443]
private_instances_ingress_rule = [22, 80, 8000]
acl_db_rule                    = [5432]
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
      rule_no   = 200
      from_port = 1024
      to_port   = 65535
  }]
}
