<!-- BEGIN_TF_DOCS -->
This module is used to deploy a RabbitMQ with a single node instance

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
| [aws_mq_broker.rabbitmq_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/mq_broker) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | Environments that we want to deploy | `string` | n/a | yes |
| <a name="input_rabbitmq_settings"></a> [rabbitmq\_settings](#input\_rabbitmq\_settings) | List of settings for RabbitMQ instance | <pre>object({<br>    engine_version     = string<br>    host_instance_type = string<br>  })</pre> | n/a | yes |
| <a name="input_security_group_id_rabbitmq"></a> [security\_group\_id\_rabbitmq](#input\_security\_group\_id\_rabbitmq) | Security groups ids for RabbitMQ | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_subnet_group_name_rabbitmq"></a> [subnet\_group\_name\_rabbitmq](#input\_subnet\_group\_name\_rabbitmq) | Subnets for RabbitMQ instance | `string` | `""` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->