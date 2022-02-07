<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_jump_host"></a> [jump\_host](#module\_jump\_host) | ../../modules/bastions | n/a |
| <a name="module_k8s"></a> [k8s](#module\_k8s) | ../../modules/eks | n/a |
| <a name="module_lb"></a> [lb](#module\_lb) | ../../modules/alb | n/a |
| <a name="module_networking"></a> [networking](#module\_networking) | ../../modules/vpc/ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acl_db_rule"></a> [acl\_db\_rule](#input\_acl\_db\_rule) | List of rule\_no and inbound ports open | <pre>object({<br>    ingress_rule = list(object({<br>      rule_no   = number<br>      from_port = number<br>      to_port   = number<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_acl_private_subnet_rule"></a> [acl\_private\_subnet\_rule](#input\_acl\_private\_subnet\_rule) | List of rule\_no and inbound ports open | <pre>object({<br>    ingress_rule = list(object({<br>      rule_no   = number<br>      from_port = number<br>      to_port   = number<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_acl_public_subnet_rule"></a> [acl\_public\_subnet\_rule](#input\_acl\_public\_subnet\_rule) | List of rule\_no and inbound ports open | <pre>object({<br>    ingress_rule = list(object({<br>      rule_no   = number<br>      from_port = number<br>      to_port   = number<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_alb_ingress_rule"></a> [alb\_ingress\_rule](#input\_alb\_ingress\_rule) | List of open ports for inbound connections | `list(number)` | n/a | yes |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | List of availability zones | `list(string)` | n/a | yes |
| <a name="input_bastion_ingress_rule"></a> [bastion\_ingress\_rule](#input\_bastion\_ingress\_rule) | List of open ports for inbound connections | `list(number)` | n/a | yes |
| <a name="input_bastions-ami"></a> [bastions-ami](#input\_bastions-ami) | Ami id used to create bastion | `string` | n/a | yes |
| <a name="input_cluster_admin_permissions"></a> [cluster\_admin\_permissions](#input\_cluster\_admin\_permissions) | List of permissions granted to admins users | <pre>list(object({<br>    api_groups = list(string)<br>    resources  = list(string)<br>    verbs      = list(string)<br>  }))</pre> | n/a | yes |
| <a name="input_db_master_password"></a> [db\_master\_password](#input\_db\_master\_password) | Master password for db | `string` | n/a | yes |
| <a name="input_db_master_username"></a> [db\_master\_username](#input\_db\_master\_username) | Master username for db | `string` | n/a | yes |
| <a name="input_db_private_subnets_cidr"></a> [db\_private\_subnets\_cidr](#input\_db\_private\_subnets\_cidr) | List of private subnets for DB | `list(string)` | `[]` | no |
| <a name="input_eks_ingress_controller_port_path"></a> [eks\_ingress\_controller\_port\_path](#input\_eks\_ingress\_controller\_port\_path) | change this variable name | <pre>object({<br>    ingress_port     = number<br>    healt_check_path = string<br>  })</pre> | n/a | yes |
| <a name="input_eks_ingress_rule"></a> [eks\_ingress\_rule](#input\_eks\_ingress\_rule) | List of open ports for inbound connections | `list(number)` | n/a | yes |
| <a name="input_eks_version"></a> [eks\_version](#input\_eks\_version) | EKS version | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environments that we want to deploy | `string` | n/a | yes |
| <a name="input_map_cluster_admin_users"></a> [map\_cluster\_admin\_users](#input\_map\_cluster\_admin\_users) | Map of full admin users on EKS | <pre>object({<br>    admins = list(object({<br>      groups   = list(string)<br>      userarn  = string<br>      username = string<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_namespaces"></a> [namespaces](#input\_namespaces) | List of namespaces created on EKS | <pre>list(object({<br>    manage = string<br>    name   = string<br>    custom_annotations = list(object({<br>      label = string<br>      value = string<br>    }))<br>    custom_labels = list(object({<br>      label = string<br>      value = string<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_private_instances_ingress_rule"></a> [private\_instances\_ingress\_rule](#input\_private\_instances\_ingress\_rule) | List of open ports for inbound connections | `list(number)` | n/a | yes |
| <a name="input_private_subnets_cidr"></a> [private\_subnets\_cidr](#input\_private\_subnets\_cidr) | List of cidr blocks | `list(string)` | n/a | yes |
| <a name="input_public_subnet_alb"></a> [public\_subnet\_alb](#input\_public\_subnet\_alb) | List of public subnets for ALB | `string` | `""` | no |
| <a name="input_public_subnets_cidr"></a> [public\_subnets\_cidr](#input\_public\_subnets\_cidr) | List of cidr blocks | `list(string)` | n/a | yes |
| <a name="input_read_only_eks_users"></a> [read\_only\_eks\_users](#input\_read\_only\_eks\_users) | Map of read only users on EKS | <pre>object({<br>    users = list(object({<br>      groups   = list(string)<br>      userarn  = string<br>      username = string<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_read_only_user_permissions"></a> [read\_only\_user\_permissions](#input\_read\_only\_user\_permissions) | List of permissions granted to read only users | <pre>list(object({<br>    api_groups = list(string)<br>    resources  = list(string)<br>    verbs      = list(string)<br>  }))</pre> | n/a | yes |
| <a name="input_sg_alb"></a> [sg\_alb](#input\_sg\_alb) | Security group for ALB | `string` | `""` | no |
| <a name="input_sg_db_rule"></a> [sg\_db\_rule](#input\_sg\_db\_rule) | List of open ports for inbound connections | `list(string)` | n/a | yes |
| <a name="input_type_resource"></a> [type\_resource](#input\_type\_resource) | Type of resource created by terraform. Values can be [durable,destroyable] | `string` | n/a | yes |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | VPC cidr block | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC id | `string` | `""` | no |
| <a name="input_worker_node_role"></a> [worker\_node\_role](#input\_worker\_node\_role) | ARN IAM worker node | `string` | n/a | yes |
| <a name="input_worker_nodes_scaling_config"></a> [worker\_nodes\_scaling\_config](#input\_worker\_nodes\_scaling\_config) | Setting for scaling nodes in EKS | <pre>object({<br>    desired_size = number<br>    max_size     = number<br>    min_size     = number<br>  })</pre> | n/a | yes |
| <a name="input_worker_nodes_update_config"></a> [worker\_nodes\_update\_config](#input\_worker\_nodes\_update\_config) | Max number of unavailable nodes at the same time | <pre>object({<br>    max_unavailable = number<br>  })</pre> | n/a | yes |
| <a name="input_workers_nodes_instance_type"></a> [workers\_nodes\_instance\_type](#input\_workers\_nodes\_instance\_type) | Instance type for worker node | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_sg"></a> [alb\_sg](#output\_alb\_sg) | Return the alb security group |
| <a name="output_arn_http_target_group"></a> [arn\_http\_target\_group](#output\_arn\_http\_target\_group) | Return ARN for HTTP target groups |
| <a name="output_azs"></a> [azs](#output\_azs) | Return the availability zones used |
| <a name="output_bastions_sg"></a> [bastions\_sg](#output\_bastions\_sg) | Return the bastions security group |
| <a name="output_db_sg"></a> [db\_sg](#output\_db\_sg) | Return the db security group |
| <a name="output_db_subnets_cidr"></a> [db\_subnets\_cidr](#output\_db\_subnets\_cidr) | Return db subnets cidr blocks |
| <a name="output_db_subnets_id"></a> [db\_subnets\_id](#output\_db\_subnets\_id) | Return db subnets id |
| <a name="output_eks_cluster_id"></a> [eks\_cluster\_id](#output\_eks\_cluster\_id) | Return cluster's name |
| <a name="output_eks_endpoint"></a> [eks\_endpoint](#output\_eks\_endpoint) | Return EKS URL API |
| <a name="output_eks_sg"></a> [eks\_sg](#output\_eks\_sg) | Return eks security group |
| <a name="output_eks_subnets"></a> [eks\_subnets](#output\_eks\_subnets) | Return the eks subnets |
| <a name="output_http_target_group"></a> [http\_target\_group](#output\_http\_target\_group) | Return HTTP target group from ALB |
| <a name="output_private_subnets_cidr"></a> [private\_subnets\_cidr](#output\_private\_subnets\_cidr) | Return the private subnets cidr |
| <a name="output_private_subnets_id"></a> [private\_subnets\_id](#output\_private\_subnets\_id) | Return the private subnets id |
| <a name="output_public_subnets_cidr"></a> [public\_subnets\_cidr](#output\_public\_subnets\_cidr) | Return the public subnets cidr |
| <a name="output_public_subnets_id"></a> [public\_subnets\_id](#output\_public\_subnets\_id) | Return the public subnets id |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | Return vpc cidr block |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | Return vpc id |
<!-- END_TF_DOCS -->