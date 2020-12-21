terraform {
  required_version = ">= 0.13.4, < 0.15.0"
  required_providers {
    kubernetes = {
      source  = "hashicorp/aws"
      version = "3.22.0"
    }
  }
}
