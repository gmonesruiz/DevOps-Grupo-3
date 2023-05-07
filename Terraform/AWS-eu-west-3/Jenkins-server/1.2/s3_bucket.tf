

############### Se configura el comportamiento de los buckets creados #################

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

################### Se habilita el versionado ####################

resource "aws_s3_bucket_versioning" "terraform_bucket_versioning" {
  count         = "${length(var.s3_bucket_name)}"
  bucket        = "${element(var.s3_bucket_name, count.index)}"
  versioning_configuration {
    status = "Enabled"
  }
}

################## Se encriptan los datos ##########################

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state_crypto_conf" {
  count         = "${length(var.s3_bucket_name)}"
  bucket        = "${element(var.s3_bucket_name, count.index)}"
    rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

################ Se crea la tabla "terraform-state-locking" en dynamodb ######################

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-state-locking"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
