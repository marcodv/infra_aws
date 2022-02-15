<!-- BEGIN_TF_DOCS -->
This module is used to deploy ElastiCache instance based on Redis engine with a single instance

ElastiCache is used by the Django apps to

A part that Redis based instance, this module also create

- cluster parameter group
- subnet group needed
- cluster user  

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
| [aws_elasticache_cluster.elasticache_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_cluster) | resource |
| [aws_elasticache_parameter_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_parameter_group) | resource |
| [aws_elasticache_subnet_group.redis_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group) | resource |
| [aws_elasticache_user.redis_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_user) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_elasticache_setting"></a> [elasticache\_setting](#input\_elasticache\_setting) | List for the Elastic Cache Redis based engine instance setting | <pre>object({<br>    engine          = string<br>    node_type       = string<br>    num_cache_nodes = number<br>    port            = number<br>    engine_version  = string<br>    family          = string<br>  })</pre> | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environments that we want to deploy | `string` | n/a | yes |
| <a name="input_redis_credentials"></a> [redis\_credentials](#input\_redis\_credentials) | Username and password for Redis user | <pre>object({<br>    username = string<br>    password = string<br>  })</pre> | n/a | yes |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Security groups ids for Elasticache | `list(string)` | n/a | yes |
| <a name="input_subnet_group_name"></a> [subnet\_group\_name](#input\_subnet\_group\_name) | Subnets for Elasticache | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_elasticache_endpoint"></a> [elasticache\_endpoint](#output\_elasticache\_endpoint) | ElastiCache endpoint |
<!-- END_TF_DOCS -->