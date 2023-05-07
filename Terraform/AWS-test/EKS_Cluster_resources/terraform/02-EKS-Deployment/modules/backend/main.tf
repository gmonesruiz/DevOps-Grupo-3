resource "aws_s3_bucket" "tfstate_bucket" {
    bucket         = var.s3_tfstate.bucket 
    key            = "terraform.tfstate"
    dynamodb_table = var.dynamodb-lock.table
    encrypt        = true
}

output "TFSTATE_BUCKET_NAME" {
  value = aws_s3_bucket.tfstate_bucket.bucket
}
