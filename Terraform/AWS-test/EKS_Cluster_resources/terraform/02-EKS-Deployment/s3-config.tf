terraform {
  backend "s3" {
    bucket         = "my-demo-bucket-terraform-2021-06-28" # REEMPLAZAR CON EL NOMBRE DEL BUCKET NECESARIO
    key            = "my-demo-bucket-terraform-2021-06-28/import-bootstrap/terraform.tfstate"
    region         = "eu-west-3"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }



}