# terraform-module-multi-efs-storage-class

Create and deploy the AWS-EFS storage class on Kubernetes.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| aws | >= 2.31.0 |
| kubernetes | >= 1.9.0 |
| random | >= 2.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| annotations | Annotations that will be applied and merged on all the kubernetes resources. | `map` | `{}` | no |
| cluster\_role\_annotations | Map of annotations that will be added to the cluster role. | `map` | `{}` | no |
| cluster\_role\_binding\_annotations | Map of annotations that will be added to the cluster role binding. | `map` | `{}` | no |
| cluster\_role\_binding\_labels | Map of labels that will be added to the cluster role binding. | `map` | `{}` | no |
| cluster\_role\_binding\_name | Name of the cluster role binding that will be created in kubernetes. | `string` | `"efs-provisioner"` | no |
| cluster\_role\_labels | Map of labels that will be added to the cluster role. | `map` | `{}` | no |
| cluster\_role\_name | Name of the cluster role that will be created in kubernetes. | `string` | `"efs-provisioner"` | no |
| deployment\_annotations | Map of annotations that will be added to the deployment. | `map` | `{}` | no |
| deployment\_labels | Map of labels that will be added to the deployment. | `map` | `{}` | no |
| deployment\_name | Name of the deployment that will be created in kubernetes. | `string` | `"efs-provisioner"` | no |
| deployment\_replicas | Number of replicas for the deployment. | `number` | `2` | no |
| efs\_allowed\_security\_group\_ids | List of security group ids that are allowed to communicate with EFS. | `list` | `[]` | no |
| efs\_kms\_key\_alias\_name | Name of the alias for the KMS key used by the AWS EFS. | `string` | `"alias/efs-storage-class-k8s"` | no |
| efs\_kms\_key\_name | Name of the KMS key used by the AWS EFS. | `string` | `"efs-storage-class-k8s"` | no |
| efs\_kms\_tags | Tags to add on the AWS EFS. | `map` | `{}` | no |
| efs\_name | Name of the AWS EFS that will be created. | `string` | n/a | yes |
| efs\_performance\_mode | Performance mode of the AWS EFS. | `string` | n/a | yes |
| efs\_provisioned\_throughput\_in\_mibps | Provisioned throughput in MiB/s for the AWS EFS. | `number` | n/a | yes |
| efs\_security\_group\_name | Name that will be given to the security group used by the AWS EFS. | `string` | n/a | yes |
| efs\_security\_group\_tags | Tags to add on the security group for AWS EFS. | `map` | `{}` | no |
| efs\_subnet\_ids | Subnet ID's from which the AWS EFS will be available. | `list` | n/a | yes |
| efs\_tags | Map of tags that will applied and merged with all the AWS EFS related resources. | `map` | `{}` | no |
| efs\_throughput\_mode | Troughput mode for the AWS EFS. | `string` | n/a | yes |
| enabled | Whether or not to enable this module. | `bool` | `true` | no |
| image\_version | Version of the docker image to use for the efs-provisionner docker image. | `string` | `"latest"` | no |
| labels | Map of labels that will be applied on all kubernetes resources. | `map` | `{}` | no |
| namespace | Namespace in which the efs-provisioner will be deployed. | `string` | `"kube-system"` | no |
| role\_annotations | Map of annotations that will be added to the cluster role. | `map` | `{}` | no |
| role\_binding\_annotations | Map of annotations that will be added to the cluster role binding. | `map` | `{}` | no |
| role\_binding\_labels | Map of labels that will be added to the cluster role binding. | `map` | `{}` | no |
| role\_binding\_name | Name of the cluster role binding that will be created in kubernetes. | `string` | `"efs-provisioner"` | no |
| role\_labels | Map of labels that will be added to the cluster role. | `map` | `{}` | no |
| role\_name | Name of the cluster role that will be created in kubernetes. | `string` | `"efs-provisioner"` | no |
| service\_account\_annotations | Map of annotations that will be added on the service account. | `map` | `{}` | no |
| service\_account\_labels | Map of labels that will be added on the service account. | `map` | `{}` | no |
| service\_account\_name | Name of the service account that will be created in kubernetes. | `string` | `"efs-provisioner"` | no |
| storage\_class\_annotations | Map of annotations that will be added on the storage class. | `map` | `{}` | no |
| storage\_class\_labels | Map of labels that will be added on the storage class. | `map` | `{}` | no |
| storage\_class\_name | Name of the storage class. | `string` | `"efs"` | no |
| tags | Map of tags that will be applied and merge with all the AWS resources. | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| cluster\_role\_binding\_name | Name of the kubernetes cluster role binding created for the efs-provisioner. |
| cluster\_role\_name | Name of the kubernetes cluster role created for the efs-provisioner. |
| deployment\_name | Name of the kubernetes deployment created for the efs-provisioner. |
| efs\_arn | Amazon Resource Name of the file system. |
| efs\_dns\_name | The DNS name for the filesystem. |
| efs\_id | The ID that identifies the file system (e.g. fs-ccfc0d65). |
| efs\_kms\_alias\_arn | The Amazon Resource Name (ARN) of the EFS key alias. This output will be empty if the KMS key was passed as variable. |
| efs\_kms\_key\_arn | The Amazon Resource Name (ARN) of the EFS key. This output will be empty if the KMS key was passed as variable. |
| efs\_kms\_key\_id | The globally unique identifier for the EFS key. This output will be empty if the KMS key was passed as variable. |
| efs\_mount\_target\_ids | The IDs of the EFS mount targets. |
| efs\_mount\_target\_network\_interface\_ids | The IDs of the network interfaces that Amazon EFS created when it created the mount targets. |
| efs\_security\_group\_id | ID of the security group used for the EFS. This output will be empty if the security groups IDs were passed as variables. |
| namespace | Namespace in which the efs-storage-class is deployed. |
| role\_binding\_name | Name of the kubernetes role binding created for the efs-provisioner. |
| role\_name | Name of the kubernetes role created for the efs-provisioner. |
| service\_account\_name | Name of the kubernetes service account created for the efs-provisioner. |
| storage\_class\_name | Name of the kubernetes storage class created. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
