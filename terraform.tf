terraform {
  required_version = ">= 1.3.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.9.0, < 5"
    }

    cloudinit = {
      source = "hashicorp/cloudinit"
      version = ">= 2.2.0, < 3"
    }
  }
}
