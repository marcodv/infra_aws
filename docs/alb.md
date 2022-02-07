<!-- BEGIN_TF_DOCS -->
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
| [aws_alb.alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb) | resource |
| [aws_alb_listener.http_listener_alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_listener) | resource |
| [aws_alb_target_group.http_tg_alb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/alb_target_group) | resource |
| [aws_lb_listener_rule.http_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_eks_ingress_controller_port_path"></a> [eks\_ingress\_controller\_port\_path](#input\_eks\_ingress\_controller\_port\_path) | n/a | <pre>object({<br>    ingress_port     = number<br>    healt_check_path = string<br>  })</pre> | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `any` | n/a | yes |
| <a name="input_public_subnet_alb"></a> [public\_subnet\_alb](#input\_public\_subnet\_alb) | n/a | `any` | n/a | yes |
| <a name="input_sg_alb"></a> [sg\_alb](#input\_sg\_alb) | n/a | `any` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn_http_target_group"></a> [arn\_http\_target\_group](#output\_arn\_http\_target\_group) | Return ARN for HTTP target group |
| <a name="output_name_http_target_group"></a> [name\_http\_target\_group](#output\_name\_http\_target\_group) | Return HTTP target group name for ALB |
<!-- END_TF_DOCS -->