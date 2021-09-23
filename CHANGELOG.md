# CHANGELOG

## 1.0.0

* (BREAKING) chore: pins `pre-commit-hooks` to `v4.0.1`.
* (BREAKING) chore: pins `kubernetes` provider to `2.x+`.
* (BREAKING) chore: pins `random` provider to `3.x+`.
* (BREAKING) chore: bump `aws-eks` module version to `3.0.0`.
* (BREAKING) chore: bump `aws-eks-worker-pool` module version to `5.0.0`.
* feat: add `pre-commit-afcmf` (`v0.1.2`).
* chore: pins `pre-commit-terraform` to `v1.50.0`.
* refactor: default example:
  * add `versions.tf` file.
  * add `README.md` file.
  * lint code.
* fix: `LICENSE` file.

## 0.7.0

* fix: Remove old list function deprecated since terraform 0.12
* chore: bump pre-commit hooks

## 0.6.0
* feat: allow user to use custom image by setting variable

## 0.5.0
* feat: allows cidrs to access the EFS sharte.

## 0.4.0

* fix: Make labels respect best practices
* chore: Update example
* chore: Update example with latest version of EKS

## 0.3.0
* feat: Use efs module version 2.1.1

## 0.2.0

* feat: Add implicit dependecies for clean destroy

## 0.1.1

* Change source from SSH to HTTPS
