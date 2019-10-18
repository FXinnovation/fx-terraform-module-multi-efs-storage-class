variable "annotations" {
  description = "Annotations that will be applied and merged on all the kubernetes resources."
  default = {}
}

variable "cluster_role_binding_annotations" {
  description = "Map of annotations that will be added to the cluster role binding."
  default = {}
}

variable "cluster_role_binding_labels" {
  description = "Map of labels that will be added to the cluster role binding."
  default = {}
}

variable "cluster_role_binding_name" {
  description = "Name of the cluster role binding that will be created in kubernetes."
  default = "efs-provisioner"
}

variable "cluster_role_annotations" {
  description = "Map of annotations that will be added to the cluster role."
  default = {}
}

variable "cluster_role_labels" {
  description = "Map of labels that will be added to the cluster role."
  default = {}
}

variable "cluster_role_name" {
  description = "Name of the cluster role that will be created in kubernetes."
  default = "efs-provisioner"
}

variable "deployment_name" {
  description = "Name of the deployment that will be created in kubernetes."
  default = "efs-provisioner"
}

variable "deployment_annotations" {
  description = "Map of annotations that will be added to the deployment."
  default = {}
}

variable "deployment_labels" {
  description = "Map of labels that will be added to the deployment."
  default = {}
}

variable "deployment_replicas" {
  description = "Number of replicas for the deployment."
  default = 2
}

variable "efs_name" {
  description = "Name of the AWS EFS that will be created."
  type = string
}

variable "efs_performance_mode" {
  description = "Performance mode of the AWS EFS."
  default = ""
}

variable "efs_provisioned_throughput_in_mibps" {
  description = "Provisioned throughput in MiB/s for the AWS EFS."
  default = ""
}

variable "efs_troughput_mode" {
  description = "Troughput mode for the AWS EFS."
  default = ""
}

variable "efs_tags" {
  description = "Tags to add on the AWS EFS."
  default = {}
}

variable "efs_kms_key_alias_name" {
  description = "Name of the alias for the KMS key used by the AWS EFS."
  default = ""
}

variable "efs_kms_key_name" {
  description = "Name of the KMS key used by the AWS EFS."
  default = ""
}

variable "efs_kms_tags" {
  description = "Tags to add on the AWS EFS."
  default = {}
}

variable "efs_security_group_name" {
  description = "Name that will be given to the security group used by the AWS EFS."
  type = string
}

variable "efs_security_group_tags" {
  description = "Tags to add on the security group for AWS EFS."
  default = {}
}

variable "efs_subnet_ids" {
  description = "Subnet ID's from which the AWS EFS will be available."
  type = list
}

variable "efs_tags" {
  description = "Map of tags that will applied and merged with all the AWS EFS related resources."
  default = {}
}

variable "enabled" {
  description = "Whether or not to enable this module."
  default = true
}

variable "image_version" {
  description = "Version of the docker image to use for the efs-provisionner docker image."
  default = "latest"
}

variable "labels" {
  description = "Map of labels that will be applied on all kubernetes resources."
  default = {}
}

variable "namespace" {
  description = "Namespace in which the efs-provisioner will be deployed."
  default = "kube-system"
}

variable "role_binding_annotations" {
  description = "Map of annotations that will be added to the cluster role binding."
  default = {}
}

variable "role_binding_labels" {
  description = "Map of labels that will be added to the cluster role binding."
  default = {}
}

variable "role_binding_name" {
  description = "Name of the cluster role binding that will be created in kubernetes."
  default = "efs-provisioner"
}

variable "role_annotations" {
  description = "Map of annotations that will be added to the cluster role."
  default = {}
}

variable "role_labels" {
  description = "Map of labels that will be added to the cluster role."
  default = {}
}

variable "role_name" {
  description = "Name of the cluster role that will be created in kubernetes."
  default = "efs-provisioner"
}

variable "serivce_account_name" {
  description = "Name of the service account that will be created in kubernetes."
  default = "efs-provisioner"
}

variable "service_account_annotations" {
  description = "Map of annotations that will be added on the service account."
  default = {}
}

variable "service_account_labels" {
  description = "Map of labels that will be added on the service account."
  default = {}
}

variable "storage_class_name" {
  description = "Name of the storage class."
  default = "efs"
}

variable "storage_class_annotations" {
  description = "Map of annotations that will be added on the storage class."
  default = {}
}

variable "storage_class_labels" {
  description = "Map of labels that will be added on the storage class."
  default = {}
}

variable "tags" {
  description = "Map of tags that will be applied and merge with all the AWS resources."
  default = {}
}
