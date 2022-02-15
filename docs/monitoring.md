<!-- BEGIN_TF_DOCS -->
This module is used to deploy Prometheus using Helm provider from Terraform

Prometheus is used to gather metrics and then these will be displayed from Grafana

Grafana will be provisioned with dashboards

At this stage, will be setup 2 dashboard which will show

- Node metrics with CPU, Memory
- Pods metrics

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_grafana"></a> [grafana](#requirement\_grafana) | >= 1.10.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.grafana](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.prometheus](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [aws_eks_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |
| [template_file.grafana_values](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Cluster name | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environments that we want to deploy | `string` | n/a | yes |
| <a name="input_grafana_access_credentials"></a> [grafana\_access\_credentials](#input\_grafana\_access\_credentials) | These are the creds set for access to Grafana dashboard | <pre>object({<br>    username = string<br>    password = string<br>  })</pre> | n/a | yes |
| <a name="input_grafana_dashboard_list"></a> [grafana\_dashboard\_list](#input\_grafana\_dashboard\_list) | Grafana dashboard list to import on EKS | `list(string)` | n/a | yes |
| <a name="input_grafana_setting"></a> [grafana\_setting](#input\_grafana\_setting) | List of Grafana setting to apply to deployment | <pre>object({<br>    grafana_version = string<br>    persistence_enabled = string<br>    storage_class = string<br>    storage_size = string<br>  })</pre> | n/a | yes |
| <a name="input_prometheus_setting"></a> [prometheus\_setting](#input\_prometheus\_setting) | Setting for Prometheus | <pre>object({<br>    prometheus_version = string<br>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->