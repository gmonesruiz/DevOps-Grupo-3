terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      region  = var.aws_region
      profile = var.aws_profile
    }
  }
}
