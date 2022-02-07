<!-- BEGIN_TF_DOCS -->
This module is used to deploy EKS version 1.21 with instances managed by a worker node group

The worker nodes are deployed in private subnet and for now we only have 1 node

Also it cames with IAM users mapped to the cluster in order to manage it.

These are the resources created in this module

- EKS cluster
- Cluster full admin/read only users mapped in the aws\_auth configMap
- Node Group
- Logs enabled and differentiates by environment: dev/prod
- Tags
- Metrics server for horizontal pods scaling
- K8s API PUBLIC ENDPOINT (means that is reachable from anywhere)
- Cluster Role in order to access/manage AWS resources
- Worker Role for in order to access/manage AWS resources

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eks_cluster.eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster) | resource |
| [aws_eks_node_group.node_group_eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |
| [kubernetes_cluster_role.cluster_full_admin_role](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role_binding.cluster_full_admin_role_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_config_map.aws_auth](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_namespace.namespaces](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_role.cluster_role_read_only](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role) | resource |
| [kubernetes_role_binding.cluster_read_only_role_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_eks_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_admin_permissions"></a> [cluster\_admin\_permissions](#input\_cluster\_admin\_permissions) | List of permissions granted to admins users | <pre>list(object({<br>    api_groups = list(string)<br>    resources  = list(string)<br>    verbs      = list(string)<br>  }))</pre> | n/a | yes |
| <a name="input_eks_sg"></a> [eks\_sg](#input\_eks\_sg) | Security group associate to EKS nodes | `string` | n/a | yes |
| <a name="input_eks_subnets"></a> [eks\_subnets](#input\_eks\_subnets) | Subnets where deploy EKS | `list(string)` | n/a | yes |
| <a name="input_eks_version"></a> [eks\_version](#input\_eks\_version) | EKS version | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environments that we want to deploy | `string` | n/a | yes |
| <a name="input_map_cluster_admin_users"></a> [map\_cluster\_admin\_users](#input\_map\_cluster\_admin\_users) | Map of full admin users on EKS | <pre>object({<br>    admins = list(object({<br>      groups   = list(string)<br>      userarn  = string<br>      username = string<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_namespaces"></a> [namespaces](#input\_namespaces) | List of namespaces created on EKS | <pre>list(object({<br>    manage = string<br>    name   = string<br>    custom_annotations = list(object({<br>      label = string<br>      value = string<br>    }))<br>    custom_labels = list(object({<br>      label = string<br>      value = string<br>    }))<br>  }))</pre> | n/a | yes |
| <a name="input_read_only_eks_users"></a> [read\_only\_eks\_users](#input\_read\_only\_eks\_users) | Map of read only users on EKS | <pre>object({<br>    users = list(object({<br>      groups   = list(string)<br>      userarn  = string<br>      username = string<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_read_only_user_permissions"></a> [read\_only\_user\_permissions](#input\_read\_only\_user\_permissions) | List of permissions granted to read only users | <pre>list(object({<br>    api_groups = list(string)<br>    resources  = list(string)<br>    verbs      = list(string)<br>  }))</pre> | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC id where deploy EKS | `string` | n/a | yes |
| <a name="input_worker_node_role"></a> [worker\_node\_role](#input\_worker\_node\_role) | ARN IAM worker node | `string` | n/a | yes |
| <a name="input_worker_nodes_scaling_config"></a> [worker\_nodes\_scaling\_config](#input\_worker\_nodes\_scaling\_config) | Setting for scaling nodes in EKS | <pre>object({<br>    desired_size = number<br>    max_size     = number<br>    min_size     = number<br>  })</pre> | n/a | yes |
| <a name="input_worker_nodes_update_config"></a> [worker\_nodes\_update\_config](#input\_worker\_nodes\_update\_config) | Max number of unavailable nodes at the same time | <pre>object({<br>    max_unavailable = number<br>  })</pre> | n/a | yes |
| <a name="input_workers_nodes_instance_type"></a> [workers\_nodes\_instance\_type](#input\_workers\_nodes\_instance\_type) | Instance type for worker node | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eks_cluster_id"></a> [eks\_cluster\_id](#output\_eks\_cluster\_id) | Return cluster's name |
| <a name="output_eks_endpoint"></a> [eks\_endpoint](#output\_eks\_endpoint) | Return EKS URL API |
<!-- END_TF_DOCS -->