<!-- BEGIN_TF_DOCS -->
This module is used to deploy a SINGLE Postgres DB version 13 in one of the 2 Private AZ.

Also created a parameter group which defined the parameters that
we need to update or change

The DB creation depend from the db parameters group and also the private subnets.

DB passwd and username are stored in [GitLab group variables section](https://gitlab.com/groups/noah-energy/-/settings/ci_cd)

DB credentials are passed to Terraform at pipeline execution time

The DB created have these configurations:

- 10GB of storage
- Tagged by AZ and environment
- Port open: 5432

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
| [aws_db_instance.db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_parameter_group.pg_db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_subnet_group.subnet_group_name](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azs"></a> [azs](#input\_azs) | n/a | `any` | n/a | yes |
| <a name="input_db_master_password"></a> [db\_master\_password](#input\_db\_master\_password) | n/a | `any` | n/a | yes |
| <a name="input_db_master_username"></a> [db\_master\_username](#input\_db\_master\_username) | n/a | `any` | n/a | yes |
| <a name="input_db_sg"></a> [db\_sg](#input\_db\_sg) | n/a | `any` | n/a | yes |
| <a name="input_db_subnets"></a> [db\_subnets](#input\_db\_subnets) | n/a | `any` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `any` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db-endpoint"></a> [db-endpoint](#output\_db-endpoint) | Return db endpoint |
<!-- END_TF_DOCS -->