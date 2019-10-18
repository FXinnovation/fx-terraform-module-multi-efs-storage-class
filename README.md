# terraform-module-multi-efs-storage-class

Create and deploy the AWS-EFS storage class on Kubernetes.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| annotations | Annotations that will be applied and merged on all the kubernetes resources. | map | `{}` | no |
| cluster\_role\_annotations | Map of annotations that will be added to the cluster role. | map | `{}` | no |
| cluster\_role\_binding\_annotations | Map of annotations that will be added to the cluster role binding. | map | `{}` | no |
| cluster\_role\_binding\_labels | Map of labels that will be added to the cluster role binding. | map | `{}` | no |
| cluster\_role\_binding\_name | Name of the cluster role binding that will be created in kubernetes. | string | `"efs-provisioner"` | no |
| cluster\_role\_labels | Map of labels that will be added to the cluster role. | map | `{}` | no |
| cluster\_role\_name | Name of the cluster role that will be created in kubernetes. | string | `"efs-provisioner"` | no |
| deployment\_annotations | Map of annotations that will be added to the deployment. | map | `{}` | no |
| deployment\_labels | Map of labels that will be added to the deployment. | map | `{}` | no |
| deployment\_name | Name of the deployment that will be created in kubernetes. | string | `"efs-provisioner"` | no |
| deployment\_replicas | Number of replicas for the deployment. | string | `"2"` | no |
| efs\_kms\_key\_alias\_name | Name of the alias for the KMS key used by the AWS EFS. | string | `""` | no |
| efs\_kms\_key\_name | Name of the KMS key used by the AWS EFS. | string | `""` | no |
| efs\_kms\_tags | Tags to add on the AWS EFS. | map | `{}` | no |
| efs\_name | Name of the AWS EFS that will be created. | string | n/a | yes |
| efs\_performance\_mode | Performance mode of the AWS EFS. | string | `""` | no |
| efs\_provisioned\_throughput\_in\_mibps | Provisioned throughput in MiB/s for the AWS EFS. | string | `""` | no |
| efs\_security\_group\_name | Name that will be given to the security group used by the AWS EFS. | string | n/a | yes |
| efs\_security\_group\_tags | Tags to add on the security group for AWS EFS. | map | `{}` | no |
| efs\_subnet\_ids | Subnet ID's from which the AWS EFS will be available. | list | n/a | yes |
| efs\_tags | Map of tags that will applied and merged with all the AWS EFS related resources. | map | `{}` | no |
| efs\_tags | Tags to add on the AWS EFS. | map | `{}` | no |
| efs\_troughput\_mode | Troughput mode for the AWS EFS. | string | `""` | no |
| enabled | Whether or not to enable this module. | string | `"true"` | no |
| image\_version | Version of the docker image to use for the efs-provisionner docker image. | string | `"latest"` | no |
| labels | Map of labels that will be applied on all kubernetes resources. | map | `{}` | no |
| namespace | Namespace in which the efs-provisioner will be deployed. | string | `"kube-system"` | no |
| role\_annotations | Map of annotations that will be added to the cluster role. | map | `{}` | no |
| role\_binding\_annotations | Map of annotations that will be added to the cluster role binding. | map | `{}` | no |
| role\_binding\_labels | Map of labels that will be added to the cluster role binding. | map | `{}` | no |
| role\_binding\_name | Name of the cluster role binding that will be created in kubernetes. | string | `"efs-provisioner"` | no |
| role\_labels | Map of labels that will be added to the cluster role. | map | `{}` | no |
| role\_name | Name of the cluster role that will be created in kubernetes. | string | `"efs-provisioner"` | no |
| serivce\_account\_name | Name of the service account that will be created in kubernetes. | string | `"efs-provisioner"` | no |
| service\_account\_annotations | Map of annotations that will be added on the service account. | map | `{}` | no |
| service\_account\_labels | Map of labels that will be added on the service account. | map | `{}` | no |
| storage\_class\_annotations | Map of annotations that will be added on the storage class. | map | `{}` | no |
| storage\_class\_labels | Map of labels that will be added on the storage class. | map | `{}` | no |
| storage\_class\_name | Name of the storage class. | string | `"efs"` | no |
| tags | Map of tags that will be applied and merge with all the AWS resources. | map | `{}` | no |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
