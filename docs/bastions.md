<!-- BEGIN_TF_DOCS -->
This module is used to deploy bastions for access to EKS worker nodes

The bastions will be deployed in public subnets
Each of them have these configurations

- Kubectl already installed
- Tagged by AZ and environment
- Port open: 22, 80, 443

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
| [aws_instance.bastions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | n/a | `any` | n/a | yes |
| <a name="input_bastions-ami"></a> [bastions-ami](#input\_bastions-ami) | n/a | `any` | n/a | yes |
| <a name="input_bastions_sg"></a> [bastions\_sg](#input\_bastions\_sg) | n/a | `any` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `any` | n/a | yes |
| <a name="input_public_subnets_id"></a> [public\_subnets\_id](#input\_public\_subnets\_id) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->