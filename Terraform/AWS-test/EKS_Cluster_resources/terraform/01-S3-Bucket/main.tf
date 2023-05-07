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


}


resource "aws_s3_bucket" "terraform_state" {
  bucket        = var.s3_tfstate.bucket # REEMPLAZAR CON EL NOMBRE DEL BUCKET NECESARIO
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "terraform_bucket_versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_crypto_conf" {
  bucket = aws_s3_bucket.terraform_state.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.dynamodb-lock.table
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
