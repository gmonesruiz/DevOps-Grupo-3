provider "aws" {
  region = "us-east-1"
  access_key = "<ACCESS_KEY>"
  secret_key = "<SECRET_KEY>"
}
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

# Crear cluster de Kubernetes
resource "aws_eks_cluster" "kubernetes_cluster" {
  name = "my-cluster"
  role_arn = aws_iam_role.cluster.arn
  vpc_config {
    security_group_ids = [aws_security_group.kubernetes.id]
    subnet_ids = aws_subnet.private.*.id
  }
}

# Crear base de datos MongoDB
resource "aws_docdb_cluster_instance" "mongodb_instances" {
  count = 3
  identifier = "mongodb-instance-${count.index + 1}"
  instance_class = "db.t3.medium"
  engine = "docdb"
  engine_version = var.mongo_version
  db_subnet_group_name = aws_docdb_subnet_group.name
  db_cluster_identifier = aws_docdb_cluster.default.id
}
