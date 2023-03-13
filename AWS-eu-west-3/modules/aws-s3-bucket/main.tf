terraform {
#  #############################################################
#  ## Despues de correr terraform apply,
#  ## se puede descomentar esta parte o  copiar al main,
#  ## de esta manera se cambia de BACKEND local a BACKEND en AWS.
#  #############################################################
#    backend "s3" {
#      bucket         = "devops-bootcamp-grupo3" # REEMPLAZAR CON EL NOMBRE DEL BUCKET NECESARIO
#      key            = "grupo-3/import-bootstrap/terraform.tfstate"
#      region         = "eu-west-3"
#      dynamodb_table = "terraform-state-locking"
#      encrypt        = true
#    }
#

#  ## Se crean los recursos para poder guardar el state de terraform

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.24"
    }
  }
}

provider "aws" {
  region = "eu-west-3"
}

############## Pruebas de AWS_S3 #######################

variable "s3_bucket_name" {
  type    = list(string)
  default = ["grupo-3-staging-cluster", "grupo-3-production-cluster", "grupo-3-dev-cluster"]
}

resource "aws_s3_bucket" "terraform_state" {
  count         = "${length(var.s3_bucket_name)}"
  bucket        = "${element(var.s3_bucket_name, count.index)}"
  acl           = "private"
  force_destroy = "true"
    lifecycle_rule {
    enabled = true

    transition {
      days = 180
      storage_class = "STANDARD_IA"
    }

    transition {
      days = 360
      storage_class = "GLACIER"
    }
  }
}

#resource "aws_s3_bucket" "terraform_state" {
#  bucket        = "devops-bootcamp-grupo3" # REEMPLAZAR CON EL NOMBRE DEL BUCKET NECESARIO
#  force_destroy = true
#}
resource "aws_s3_bucket_versioning" "terraform_bucket_versioning" {
  count         = "${length(var.s3_bucket_name)}"
  bucket        = "${element(var.s3_bucket_name, count.index)}"
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_crypto_conf" {
  count         = "${length(var.s3_bucket_name)}"
  bucket        = "${element(var.s3_bucket_name, count.index)}"
    rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-state-locking"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
