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
# Security Group
#####

resource "aws_security_group" "this" {
  name   = "sg${random_string.this.result}"
  vpc_id = data.aws_vpc.this.id
}

resource "aws_security_group" "this_worker" {
  name   = "sg${random_string.this.result}"
  vpc_id = data.aws_vpc.this.id
}


#####
# EKS Cluster
#####

module "eks" {
  source = "git::ssh://git@scm.dazzlingwrench.fxinnovation.com:2222/fxinnovation-public/terraform-module-aws-eks.git?ref=3.0.0"

  allowed_security_group_ids   = [aws_security_group.this.id]
  allowed_security_group_count = 1

  iam_role_name       = "eks${random_string.this.result}"
  name                = "eks${random_string.this.result}"
  security_group_name = "eks${random_string.this.result}"
  subnet_ids          = tolist(data.aws_subnet_ids.this.ids)
}


#####
# EKS Worker Pool
#####

module "eks_worker_pool" {
  source = "git::ssh://git@scm.dazzlingwrench.fxinnovation.com:2222/fxinnovation-public/terraform-module-aws-eks-worker-pool.git?ref=5.0.0"

  autoscaling_group_name    = "ekswp${random_string.this.result}"
  cluster_name              = module.eks.name
  cluster_security_group_id = module.eks.security_group_id
  iam_instance_profile_name = "ekswp${random_string.this.result}"
  iam_role_name             = "ekswp${random_string.this.result}"
  kubernetes_version        = module.eks.kubernetes_version
  name_prefix               = random_string.this.result
  security_group_ids        = [aws_security_group.this_worker.id]
  security_group_name       = "ekswp${random_string.this.result}"
  subnet_ids                = tolist(data.aws_subnet_ids.this.ids)
}


#####
# EFS Storage Class
#####
module "efs_storage_class" {
  source = "../../"

  deployment_replicas            = 0
  efs_allowed_security_group_ids = [module.eks.security_group_id, aws_security_group.this_worker.id]
  efs_kms_key_alias_name         = "alias/efs-storage-class-k8s-${random_string.this.result}"
  efs_kms_key_name               = "efs-storage-class-k8s-${random_string.this.result}"
  efs_name                       = random_string.this.result
  efs_security_group_name        = random_string.this.result
  efs_subnet_ids                 = tolist(data.aws_subnet_ids.this.ids)
}
