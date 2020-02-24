terraform {
  required_version = ">= 0.12"

  required_providers {
    kubernetes = ">= 1.9.0"
    random     = ">= 2.0.0"
    aws        = ">= 2.31.0"
  }
}
