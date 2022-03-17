#####
# Datasources
#####

data "aws_region" "this" {}

#####
# Locals
#####

locals {
  labels = {
    "name"       = "efs-provisioner"
    "version"    = var.image_version
    "part-of"    = "storage"
    "managed-by" = "terraform"
  }
}

#####
# Randoms
#####

resource "random_string" "selector" {
  count = var.enabled ? 1 : 0

  special = false
  upper   = false
  length  = 20
}


#####
# EFS
#####

module "efs" {
  source = "git::https://github.com/FXinnovation/fx-terraform-module-aws-efs.git?ref=2.1.1"

  enabled                         = var.enabled
  name                            = var.efs_name
  performance_mode                = var.efs_performance_mode
  provisioned_throughput_in_mibps = var.efs_provisioned_throughput_in_mibps
  throughput_mode                 = var.efs_throughput_mode
  allowed_security_group_ids      = var.efs_allowed_security_group_ids
  efs_tags                        = var.efs_tags
  kms_key_alias_name              = var.efs_kms_key_alias_name
  kms_key_name                    = var.efs_kms_key_name
  kms_key_create                  = true
  kms_tags                        = var.efs_kms_tags
  ssm_parameter_enabled           = false
  security_group_name             = var.efs_security_group_name
  security_group_tags             = var.efs_security_group_tags
  subnet_ids                      = var.efs_subnet_ids
  tags                            = merge(var.tags, var.efs_tags)
  allowed_cidrs                   = var.efs_allowed_cidrs
}

#####
# Kubernetes RBAC
#####

resource "kubernetes_service_account" "this" {
  count = var.enabled ? 1 : 0

  metadata {
    name      = var.service_account_name
    namespace = var.namespace
    annotations = merge(
      var.annotations,
      var.service_account_annotations
    )
    labels = merge(
      {
        "instance" = var.service_account_name
      },
      local.labels,
      var.labels,
      var.service_account_labels
    )
  }
}

resource "kubernetes_cluster_role" "this" {
  count = var.enabled ? 1 : 0

  metadata {
    name = var.cluster_role_name
    annotations = merge(
      var.annotations,
      var.cluster_role_annotations
    )
    labels = merge(
      {
        "instance"  = var.cluster_role_name
        "component" = "rbac"
      },
      local.labels,
      var.labels,
      var.cluster_role_labels
    )
  }

  rule {
    api_groups = [""]
    resources  = ["persistentvolumes"]
    verbs      = ["get", "list", "watch", "create", "delete"]
  }

  rule {
    api_groups = [""]
    resources  = ["persistentvolumeclaims"]
    verbs      = ["get", "list", "watch", "update"]
  }

  rule {
    api_groups = ["storage.k8s.io"]
    resources  = ["storageclasses"]
    verbs      = ["get", "list", "watch"]
  }

  rule {
    api_groups = [""]
    resources  = ["events"]
    verbs      = ["create", "update", "patch"]
  }
}

resource "kubernetes_cluster_role_binding" "this" {
  count = var.enabled ? 1 : 0

  metadata {
    name = var.cluster_role_binding_name
    annotations = merge(
      var.annotations,
      var.cluster_role_binding_annotations
    )
    labels = merge(
      {
        "instance"  = var.cluster_role_binding_name
        "component" = "rbac"
      },
      local.labels,
      var.labels,
      var.cluster_role_binding_labels
    )
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = element(concat(kubernetes_cluster_role.this.*.metadata.0.name, list("")), 0)
  }

  subject {
    kind      = "ServiceAccount"
    name      = element(concat(kubernetes_service_account.this.*.metadata.0.name, list("")), 0)
    namespace = var.namespace
  }
}

resource "kubernetes_role" "this" {
  count = var.enabled ? 1 : 0

  metadata {
    name      = var.role_name
    namespace = var.namespace
    annotations = merge(
      var.annotations,
      var.role_annotations
    )
    labels = merge(
      {
        "instance"  = var.role_name
        "component" = "rbac"
      },
      local.labels,
      var.labels,
      var.role_labels
    )
  }

  rule {
    api_groups = [""]
    resources  = ["endpoints"]
    verbs      = ["get", "list", "watch", "create", "update", "patch"]
  }
}

resource "kubernetes_role_binding" "this" {
  count = var.enabled ? 1 : 0

  metadata {
    name      = var.role_binding_name
    namespace = var.namespace
    annotations = merge(
      var.annotations,
      var.role_binding_annotations
    )
    labels = merge(
      {
        "instance"  = var.role_binding_name
        "component" = "rbac"
      },
      local.labels,
      var.labels,
      var.role_binding_labels
    )
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = element(concat(kubernetes_role.this.*.metadata.0.name, list("")), 0)
  }

  subject {
    kind      = "ServiceAccount"
    name      = element(concat(kubernetes_service_account.this.*.metadata.0.name, list("")), 0)
    namespace = var.namespace
  }
}

#####
# Storage Class
#####

resource "kubernetes_storage_class" "this" {
  count = var.enabled ? 1 : 0

  metadata {
    name = var.storage_class_name
    annotations = merge(
      var.annotations,
      var.storage_class_annotations
    )
    labels = merge(
      {
        "instance"  = var.storage_class_name
        "component" = "storage-class"
      },
      local.labels,
      var.labels,
      var.storage_class_labels
    )
  }

  storage_provisioner = "aws.amazon.com/efs"
}

#####
# Deployment
#####

resource "kubernetes_deployment" "this" {
  count = var.enabled ? 1 : 0

  metadata {
    name      = var.deployment_name
    namespace = var.namespace
    annotations = merge(
      map("fxinnovation.com/dependency", sha256(format("%s-%s", module.efs.kms_alias_arn, join("-", module.efs.security_group_rule_ids, module.efs.efs_mount_target_ids)))),
      var.annotations,
      var.deployment_annotations
    )
    labels = merge(
      {
        "instance"  = var.deployment_name
        "component" = "backend"
      },
      local.labels,
      var.labels,
      var.deployment_labels
    )
  }

  spec {
    replicas = var.deployment_replicas

    strategy {
      type = "RollingUpdate"
    }

    selector {
      match_labels = {
        app    = "efs-provisioner"
        random = element(concat(random_string.selector.*.result, list("")), 0)
      }
    }

    template {
      metadata {
        annotations = merge(
          var.annotations,
          var.deployment_annotations
        )
        labels = merge(
          {
            "instance"  = var.deployment_name
            "component" = "backend"
          },
          local.labels,
          var.labels,
          var.deployment_labels,
          {
            app    = "efs-provisioner"
            random = element(concat(random_string.selector.*.result, list("")), 0)
          }
        )
      }

      spec {
        service_account_name            = element(concat(kubernetes_service_account.this.*.metadata.0.name, list("")), 0)
        automount_service_account_token = true
        container {
          image = "${var.image}:${var.image_version}"
          name  = "efs-provisioner"

          env {
            name  = "FILE_SYSTEM_ID"
            value = module.efs.efs_id
          }

          env {
            name  = "AWS_REGION"
            value = data.aws_region.this.name
          }
          env {
            name  = "DNS_NAME"
            value = module.efs.efs_dns_name
          }
          env {
            name  = "PROVISIONER_NAME"
            value = kubernetes_storage_class.this.0.storage_provisioner
          }

          volume_mount {
            mount_path = "/persistentvolumes"
            name       = "pv-volume"
          }
        }
        volume {
          name = "pv-volume"
          nfs {
            path   = "/"
            server = module.efs.efs_dns_name
          }
        }
      }
    }
  }

  depends_on = [
    kubernetes_role_binding.this,
    kubernetes_cluster_role_binding.this
  ]
}
