#####
# Randoms
#####

resource "random_string" "this" {
  length  = 8
  special = false
  upper   = false
  numeric = false
}

#####
# EKS Cluster
#####

module "worker_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name   = "worker-sg"
  vpc_id = data.aws_vpc.default.id

  ingress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "-1"
      description = "Open all"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "-1"
      description = "Open all"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

module "eks" {
  source = "github.com/FXinnovation/fx-terraform-module-aws-eks.git?ref=3.4.0"

  iam_role_name       = "eks${random_string.this.result}"
  name                = "eks${random_string.this.result}"
  security_group_name = "eks${random_string.this.result}"
  subnet_ids          = tolist(data.aws_subnets.this.ids)

  allowed_security_group_ids   = [module.worker_sg.security_group_id]
  allowed_security_group_count = 1
}

#####
# EKS Worker Pool
#####

module "eks_worker_pool" {
  source = "github.com/FXinnovation/fx-terraform-module-aws-eks-worker-pool.git?ref=5.1.0"

  autoscaling_group_name = "ekswp${random_string.this.result}"

  cluster_name              = module.eks.name
  cluster_security_group_id = module.eks.security_group_id

  kubernetes_version = module.eks.kubernetes_version

  iam_role_name             = "ekswp${random_string.this.result}"
  iam_instance_profile_name = "ekswp${random_string.this.result}"

  name_prefix = random_string.this.result

  security_group_name = "ekswp${random_string.this.result}"

  subnet_ids = tolist(data.aws_subnets.this.ids)
}

#####
# EFS Storage Class
#####
module "efs_storage_class" {
  source = "../../"

  efs_name                       = random_string.this.result
  efs_security_group_name        = random_string.this.result
  efs_subnet_ids                 = tolist(data.aws_subnets.this.ids)
  efs_allowed_security_group_ids = [module.eks.security_group_id, module.worker_sg.security_group_id]
  deployment_replicas            = 0
  efs_kms_key_name               = "efs-storage-class-k8s-${random_string.this.result}"
  efs_kms_key_alias_name         = "alias/efs-storage-class-k8s-${random_string.this.result}"

}
