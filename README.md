# terraform-module-multi-efs-storage-class

Create and deploy the AWS-EFS storage class on Kubernetes.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.31.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 1.9.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.31.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | >= 1.9.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 2.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_efs"></a> [efs](#module\_efs) | git::https://scm.dazzlingwrench.fxinnovation.com/fxinnovation-public/terraform-module-aws-efs.git | 2.1.1 |

## Resources

| Name | Type |
|------|------|
| [kubernetes_cluster_role.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role_binding.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_deployment.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/deployment) | resource |
| [kubernetes_role.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role) | resource |
| [kubernetes_role_binding.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_service_account.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |
| [kubernetes_storage_class.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/storage_class) | resource |
| [random_string.selector](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_region.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_annotations"></a> [annotations](#input\_annotations) | Annotations that will be applied and merged on all the kubernetes resources. | `map` | `{}` | no |
| <a name="input_cluster_role_annotations"></a> [cluster\_role\_annotations](#input\_cluster\_role\_annotations) | Map of annotations that will be added to the cluster role. | `map` | `{}` | no |
| <a name="input_cluster_role_binding_annotations"></a> [cluster\_role\_binding\_annotations](#input\_cluster\_role\_binding\_annotations) | Map of annotations that will be added to the cluster role binding. | `map` | `{}` | no |
| <a name="input_cluster_role_binding_labels"></a> [cluster\_role\_binding\_labels](#input\_cluster\_role\_binding\_labels) | Map of labels that will be added to the cluster role binding. | `map` | `{}` | no |
| <a name="input_cluster_role_binding_name"></a> [cluster\_role\_binding\_name](#input\_cluster\_role\_binding\_name) | Name of the cluster role binding that will be created in kubernetes. | `string` | `"efs-provisioner"` | no |
| <a name="input_cluster_role_labels"></a> [cluster\_role\_labels](#input\_cluster\_role\_labels) | Map of labels that will be added to the cluster role. | `map` | `{}` | no |
| <a name="input_cluster_role_name"></a> [cluster\_role\_name](#input\_cluster\_role\_name) | Name of the cluster role that will be created in kubernetes. | `string` | `"efs-provisioner"` | no |
| <a name="input_deployment_annotations"></a> [deployment\_annotations](#input\_deployment\_annotations) | Map of annotations that will be added to the deployment. | `map` | `{}` | no |
| <a name="input_deployment_labels"></a> [deployment\_labels](#input\_deployment\_labels) | Map of labels that will be added to the deployment. | `map` | `{}` | no |
| <a name="input_deployment_name"></a> [deployment\_name](#input\_deployment\_name) | Name of the deployment that will be created in kubernetes. | `string` | `"efs-provisioner"` | no |
| <a name="input_deployment_replicas"></a> [deployment\_replicas](#input\_deployment\_replicas) | Number of replicas for the deployment. | `number` | `2` | no |
| <a name="input_efs_allowed_cidrs"></a> [efs\_allowed\_cidrs](#input\_efs\_allowed\_cidrs) | CIDRs allowed to access the EFS. Must be a list of object containing “cidr” and “target” (the target of the CIDR). | `list` | `[]` | no |
| <a name="input_efs_allowed_security_group_ids"></a> [efs\_allowed\_security\_group\_ids](#input\_efs\_allowed\_security\_group\_ids) | List of security group ids that are allowed to communicate with EFS. | `list` | `[]` | no |
| <a name="input_efs_kms_key_alias_name"></a> [efs\_kms\_key\_alias\_name](#input\_efs\_kms\_key\_alias\_name) | Name of the alias for the KMS key used by the AWS EFS. | `string` | `"alias/efs-storage-class-k8s"` | no |
| <a name="input_efs_kms_key_name"></a> [efs\_kms\_key\_name](#input\_efs\_kms\_key\_name) | Name of the KMS key used by the AWS EFS. | `string` | `"efs-storage-class-k8s"` | no |
| <a name="input_efs_kms_tags"></a> [efs\_kms\_tags](#input\_efs\_kms\_tags) | Tags to add on the AWS EFS. | `map` | `{}` | no |
| <a name="input_efs_name"></a> [efs\_name](#input\_efs\_name) | Name of the AWS EFS that will be created. | `string` | n/a | yes |
| <a name="input_efs_performance_mode"></a> [efs\_performance\_mode](#input\_efs\_performance\_mode) | Performance mode of the AWS EFS. | `string` | `null` | no |
| <a name="input_efs_provisioned_throughput_in_mibps"></a> [efs\_provisioned\_throughput\_in\_mibps](#input\_efs\_provisioned\_throughput\_in\_mibps) | Provisioned throughput in MiB/s for the AWS EFS. | `number` | `null` | no |
| <a name="input_efs_security_group_name"></a> [efs\_security\_group\_name](#input\_efs\_security\_group\_name) | Name that will be given to the security group used by the AWS EFS. | `string` | n/a | yes |
| <a name="input_efs_security_group_tags"></a> [efs\_security\_group\_tags](#input\_efs\_security\_group\_tags) | Tags to add on the security group for AWS EFS. | `map` | `{}` | no |
| <a name="input_efs_subnet_ids"></a> [efs\_subnet\_ids](#input\_efs\_subnet\_ids) | Subnet ID's from which the AWS EFS will be available. | `list(string)` | n/a | yes |
| <a name="input_efs_tags"></a> [efs\_tags](#input\_efs\_tags) | Map of tags that will applied and merged with all the AWS EFS related resources. | `map` | `{}` | no |
| <a name="input_efs_throughput_mode"></a> [efs\_throughput\_mode](#input\_efs\_throughput\_mode) | Troughput mode for the AWS EFS. | `string` | `null` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Whether or not to enable this module. | `bool` | `true` | no |
| <a name="input_image"></a> [image](#input\_image) | Name of the image to use. | `string` | `"quay.io/external_storage/efs-provisioner"` | no |
| <a name="input_image_version"></a> [image\_version](#input\_image\_version) | Version of the docker image to use for the efs-provisionner docker image. | `string` | `"latest"` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Map of labels that will be applied on all kubernetes resources. | `map` | `{}` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace in which the efs-provisioner will be deployed. | `string` | `"kube-system"` | no |
| <a name="input_role_annotations"></a> [role\_annotations](#input\_role\_annotations) | Map of annotations that will be added to the cluster role. | `map` | `{}` | no |
| <a name="input_role_binding_annotations"></a> [role\_binding\_annotations](#input\_role\_binding\_annotations) | Map of annotations that will be added to the cluster role binding. | `map` | `{}` | no |
| <a name="input_role_binding_labels"></a> [role\_binding\_labels](#input\_role\_binding\_labels) | Map of labels that will be added to the cluster role binding. | `map` | `{}` | no |
| <a name="input_role_binding_name"></a> [role\_binding\_name](#input\_role\_binding\_name) | Name of the cluster role binding that will be created in kubernetes. | `string` | `"efs-provisioner"` | no |
| <a name="input_role_labels"></a> [role\_labels](#input\_role\_labels) | Map of labels that will be added to the cluster role. | `map` | `{}` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Name of the cluster role that will be created in kubernetes. | `string` | `"efs-provisioner"` | no |
| <a name="input_service_account_annotations"></a> [service\_account\_annotations](#input\_service\_account\_annotations) | Map of annotations that will be added on the service account. | `map` | `{}` | no |
| <a name="input_service_account_labels"></a> [service\_account\_labels](#input\_service\_account\_labels) | Map of labels that will be added on the service account. | `map` | `{}` | no |
| <a name="input_service_account_name"></a> [service\_account\_name](#input\_service\_account\_name) | Name of the service account that will be created in kubernetes. | `string` | `"efs-provisioner"` | no |
| <a name="input_storage_class_annotations"></a> [storage\_class\_annotations](#input\_storage\_class\_annotations) | Map of annotations that will be added on the storage class. | `map` | `{}` | no |
| <a name="input_storage_class_labels"></a> [storage\_class\_labels](#input\_storage\_class\_labels) | Map of labels that will be added on the storage class. | `map` | `{}` | no |
| <a name="input_storage_class_name"></a> [storage\_class\_name](#input\_storage\_class\_name) | Name of the storage class. | `string` | `"efs"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags that will be applied and merge with all the AWS resources. | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_role_binding_name"></a> [cluster\_role\_binding\_name](#output\_cluster\_role\_binding\_name) | Name of the kubernetes cluster role binding created for the efs-provisioner. |
| <a name="output_cluster_role_name"></a> [cluster\_role\_name](#output\_cluster\_role\_name) | Name of the kubernetes cluster role created for the efs-provisioner. |
| <a name="output_deployment_name"></a> [deployment\_name](#output\_deployment\_name) | Name of the kubernetes deployment created for the efs-provisioner. |
| <a name="output_efs_arn"></a> [efs\_arn](#output\_efs\_arn) | Amazon Resource Name of the file system. |
| <a name="output_efs_dns_name"></a> [efs\_dns\_name](#output\_efs\_dns\_name) | The DNS name for the filesystem. |
| <a name="output_efs_id"></a> [efs\_id](#output\_efs\_id) | The ID that identifies the file system (e.g. fs-ccfc0d65). |
| <a name="output_efs_kms_alias_arn"></a> [efs\_kms\_alias\_arn](#output\_efs\_kms\_alias\_arn) | The Amazon Resource Name (ARN) of the EFS key alias. This output will be empty if the KMS key was passed as variable. |
| <a name="output_efs_kms_key_arn"></a> [efs\_kms\_key\_arn](#output\_efs\_kms\_key\_arn) | The Amazon Resource Name (ARN) of the EFS key. This output will be empty if the KMS key was passed as variable. |
| <a name="output_efs_kms_key_id"></a> [efs\_kms\_key\_id](#output\_efs\_kms\_key\_id) | The globally unique identifier for the EFS key. This output will be empty if the KMS key was passed as variable. |
| <a name="output_efs_mount_target_ids"></a> [efs\_mount\_target\_ids](#output\_efs\_mount\_target\_ids) | The IDs of the EFS mount targets. |
| <a name="output_efs_mount_target_network_interface_ids"></a> [efs\_mount\_target\_network\_interface\_ids](#output\_efs\_mount\_target\_network\_interface\_ids) | The IDs of the network interfaces that Amazon EFS created when it created the mount targets. |
| <a name="output_efs_security_group_id"></a> [efs\_security\_group\_id](#output\_efs\_security\_group\_id) | ID of the security group used for the EFS. This output will be empty if the security groups IDs were passed as variables. |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | Namespace in which the efs-storage-class is deployed. |
| <a name="output_role_binding_name"></a> [role\_binding\_name](#output\_role\_binding\_name) | Name of the kubernetes role binding created for the efs-provisioner. |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | Name of the kubernetes role created for the efs-provisioner. |
| <a name="output_service_account_name"></a> [service\_account\_name](#output\_service\_account\_name) | Name of the kubernetes service account created for the efs-provisioner. |
| <a name="output_storage_class_name"></a> [storage\_class\_name](#output\_storage\_class\_name) | Name of the kubernetes storage class created. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
