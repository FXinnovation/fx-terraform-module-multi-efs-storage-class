#####
# Randoms
#####

resource "random_string" "this" {
  length  = 8
  special = false
  upper   = false
  number  = false
}


#####
# EKS Cluster
#####

module "eks" {
  source = "git::ssh://git@scm.dazzlingwrench.fxinnovation.com:2222/fxinnovation-public/terraform-module-aws-eks.git?ref=2.0.0"

  iam_role_name       = "eks${random_string.this.result}"
  name                = "eks${random_string.this.result}"
  security_group_name = "eks${random_string.this.result}"
  subnet_ids          = tolist(data.aws_subnet_ids.this.ids)

  allowed_security_group_ids   = [module.eks_worker_pool.security_group_id]
  allowed_security_group_count = 1
}


#####
# EKS Worker Pool
#####

module "eks_worker_pool" {
  source = "git::ssh://git@scm.dazzlingwrench.fxinnovation.com:2222/fxinnovation-public/terraform-module-aws-eks-worker-pool.git?ref=1.0.0"

  autoscaling_group_name = "ekswp${random_string.this.result}"

  cluster_name              = module.eks.name
  cluster_security_group_id = module.eks.security_group_id

  kubernetes_version = module.eks.kubernetes_version

  iam_role_name             = "ekswp${random_string.this.result}"
  iam_instance_profile_name = "ekswp${random_string.this.result}"

  name_prefix = random_string.this.result

  security_group_name = "ekswp${random_string.this.result}"

  subnet_ids = tolist(data.aws_subnet_ids.this.ids)
}


#####
# EFS Storage Class
#####
module "efs_storage_class" {
  source = "../../"

  efs_name                       = random_string.this.result
  efs_security_group_name        = random_string.this.result
  efs_subnet_ids                 = tolist(data.aws_subnet_ids.this.ids)
  efs_allowed_security_group_ids = [module.eks.security_group_id, module.eks_worker_pool.security_group_id]
  deployment_replicas            = 0
  efs_kms_key_name               = "efs-storage-class-k8s-${random_string.this.result}"
  efs_kms_key_alias_name         = "alias/efs-storage-class-k8s-${random_string.this.result}"

}
