
variable "region" {
  default = "us-east-1"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "instance_count" {
  default = 2
}

variable "mongo_version" {
  default = "4.4"
}
# Crear instancias EC2
resource "aws_instance" "ec2_instances" {
  count = var.instance_count
  ami = "ami-0c55b159cbfafe1f0"
  instance_type = var.instance_type
  tags = {
    Name = "ec2-instance-${count.index + 1}"
  }
}

############## Pruebas de AWS_S3 #######################

variable "s3_bucket_name" {
  type    = list(string)
  default = ["mongodb", "test", "staging", "dev", "sandbox"]
}

resource "aws_s3_bucket" "bucket" {
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
