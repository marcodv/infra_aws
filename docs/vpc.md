<!-- BEGIN_TF_DOCS -->
This module is used to deploy a VPC that span across 2 AZ

In public subnets, are placed bastions for access to instance in private subnets.

In private subnets, are placed DB and EKS worker nodes.

Each resource created here, is tagged by AZ and as public/private

These are the resources created in this module

- 2 Public subnets
- 2 Private subnets for worker node
- 2 NAT gateway (1 for each AZ)
- Tags needed by EKS in order to use or place resources inside the existing VPC without creating a new one
- Security groups used by public/private subnets, bastions
- NACL used by public/private subnet, bastions

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.nat_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.ig](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_network_acl.acl_private_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl) | resource |
| [aws_network_acl.acl_public_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl) | resource |
| [aws_route.peering_prod_rds_to_private_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.private_nat_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.public_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.alb_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.bastions_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.eks_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.private_instances_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.private_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acl_private_subnet_rule"></a> [acl\_private\_subnet\_rule](#input\_acl\_private\_subnet\_rule) | List of rule\_no and inbound ports open | <pre>object({<br>    ingress_rule = list(object({<br>      rule_no   = number<br>      from_port = number<br>      to_port   = number<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_acl_public_subnet_rule"></a> [acl\_public\_subnet\_rule](#input\_acl\_public\_subnet\_rule) | List of rule\_no and inbound ports open | <pre>object({<br>    ingress_rule = list(object({<br>      rule_no   = number<br>      from_port = number<br>      to_port   = number<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_alb_ingress_rule"></a> [alb\_ingress\_rule](#input\_alb\_ingress\_rule) | List of open ports for inbound connections | `list(number)` | n/a | yes |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | List of availability zones | `list(string)` | n/a | yes |
| <a name="input_bastion_ingress_rule"></a> [bastion\_ingress\_rule](#input\_bastion\_ingress\_rule) | List of open ports for inbound connections | `list(number)` | n/a | yes |
| <a name="input_eks_ingress_rule"></a> [eks\_ingress\_rule](#input\_eks\_ingress\_rule) | List of open ports for inbound connections | `list(number)` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environments that we want to deploy | `string` | n/a | yes |
| <a name="input_private_instances_ingress_rule"></a> [private\_instances\_ingress\_rule](#input\_private\_instances\_ingress\_rule) | List of open ports for inbound connections | `list(number)` | n/a | yes |
| <a name="input_private_subnets_cidr"></a> [private\_subnets\_cidr](#input\_private\_subnets\_cidr) | List of cidr blocks | `list(string)` | n/a | yes |
| <a name="input_public_subnets_cidr"></a> [public\_subnets\_cidr](#input\_public\_subnets\_cidr) | List of cidr blocks | `list(string)` | n/a | yes |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | VPC cidr block | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azs_public_subnet"></a> [azs\_public\_subnet](#output\_azs\_public\_subnet) | Return a list of the availability zones used |
| <a name="output_bastions_sg"></a> [bastions\_sg](#output\_bastions\_sg) | Return the bastions security group id |
| <a name="output_cidr_block"></a> [cidr\_block](#output\_cidr\_block) | Return vpc cidr block |
| <a name="output_eks_sg"></a> [eks\_sg](#output\_eks\_sg) | Return eks security group id |
| <a name="output_private_subnets_cidr"></a> [private\_subnets\_cidr](#output\_private\_subnets\_cidr) | Return a list of the private subnets cidr |
| <a name="output_private_subnets_id"></a> [private\_subnets\_id](#output\_private\_subnets\_id) | Return a list of the private subnets id |
| <a name="output_public_subnets_cidr"></a> [public\_subnets\_cidr](#output\_public\_subnets\_cidr) | Return a list of the public subnets cidr |
| <a name="output_public_subnets_id"></a> [public\_subnets\_id](#output\_public\_subnets\_id) | Return a list of the public subnets id |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | Return vpc id |
<!-- END_TF_DOCS -->