# Define the required provider and profile
provider "aws" {
  region  = var.aws-region
  profile = var.aws-profile
}

# Terraform block to define the required provider and its version
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.7"
    }
  }
}
