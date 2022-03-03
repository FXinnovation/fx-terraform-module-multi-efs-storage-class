output "efs_arn" {
  description = "Amazon Resource Name of the file system."
  value       = module.efs.efs_arn
}

output "efs_id" {
  description = "The ID that identifies the file system (e.g. fs-ccfc0d65)."
  value       = module.efs.efs_id
}

output "efs_dns_name" {
  description = "The DNS name for the filesystem."
  value       = module.efs.efs_dns_name
}

output "efs_mount_target_network_interface_ids" {
  description = "The IDs of the network interfaces that Amazon EFS created when it created the mount targets."
  value       = module.efs.efs_mount_target_network_interface_ids
}

output "efs_mount_target_ids" {
  description = "The IDs of the EFS mount targets."
  value       = module.efs.efs_mount_target_ids
}

output "efs_kms_key_id" {
  description = "The globally unique identifier for the EFS key. This output will be empty if the KMS key was passed as variable."
  value       = module.efs.kms_key_id
}

output "efs_kms_key_arn" {
  description = "The Amazon Resource Name (ARN) of the EFS key. This output will be empty if the KMS key was passed as variable."
  value       = module.efs.kms_key_arn
}

output "efs_kms_alias_arn" {
  description = "The Amazon Resource Name (ARN) of the EFS key alias. This output will be empty if the KMS key was passed as variable."
  value       = module.efs.kms_alias_arn
}

output "efs_security_group_id" {
  description = "ID of the security group used for the EFS. This output will be empty if the security groups IDs were passed as variables."
  value       = module.efs.security_group_id
}

output "namespace" {
  description = "Namespace in which the efs-storage-class is deployed."
  value       = var.enabled ? var.namespace : ""
}

output "service_account_name" {
  description = "Name of the kubernetes service account created for the efs-provisioner."
  value       = element(concat(kubernetes_service_account.this.*.metadata.0.name, []), 0)
}

output "cluster_role_name" {
  description = "Name of the kubernetes cluster role created for the efs-provisioner."
  value       = element(concat(kubernetes_cluster_role.this.*.metadata.0.name, []), 0)
}

output "cluster_role_binding_name" {
  description = "Name of the kubernetes cluster role binding created for the efs-provisioner."
  value       = element(concat(kubernetes_cluster_role_binding.this.*.metadata.0.name, []), 0)
}

output "role_name" {
  description = "Name of the kubernetes role created for the efs-provisioner."
  value       = element(concat(kubernetes_role.this.*.metadata.0.name, []), 0)
}

output "role_binding_name" {
  description = "Name of the kubernetes role binding created for the efs-provisioner."
  value       = element(concat(kubernetes_role_binding.this.*.metadata.0.name, []), 0)
}

output "storage_class_name" {
  description = "Name of the kubernetes storage class created."
  value       = element(concat(kubernetes_storage_class.this.*.metadata.0.name, []), 0)
}

output "deployment_name" {
  description = "Name of the kubernetes deployment created for the efs-provisioner."
  value       = element(concat(kubernetes_deployment.this.*.metadata.0.name, []), 0)
}
