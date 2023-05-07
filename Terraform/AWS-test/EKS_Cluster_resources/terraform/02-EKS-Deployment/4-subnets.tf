# This file creates the private subnets for the EKS cluster

resource "aws_subnet" "private-subnet-region-a" {
  vpc_id            = aws_vpc.eks-main.id
  cidr_block        = var.cidr-private-subnet-a
  availability_zone = "${var.aws-region}a"

  tags = {
    Name                              = "private-${var.aws-region}a"
    Terraform                         = "true"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}

resource "aws_subnet" "private-subnet-region-b" {
  vpc_id            = aws_vpc.eks-main.id
  cidr_block        = var.cidr-private-subnet-b
  availability_zone = "${var.aws-region}b"


  tags = {
    Name                              = "private-${var.aws-region}b"
    Terraform                         = "true"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}

resource "aws_subnet" "public-subnet-region-a" {
  vpc_id                  = aws_vpc.eks-main.id
  cidr_block              = var.cidr-public-subnet-a
  availability_zone       = "${var.aws-region}a"
  map_public_ip_on_launch = true

  tags = {
    Name                              = "public-${var.aws-region}a"
    Terraform                         = "true"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}

resource "aws_subnet" "public-subnet-region-b" {
  vpc_id                  = aws_vpc.eks-main.id
  cidr_block              = var.cidr-public-subnet-b
  availability_zone       = "${var.aws-region}b"
  map_public_ip_on_launch = true

  tags = {
    Name                              = "public-${var.aws-region}b"
    Terraform                         = "true"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/demo"      = "owned"
  }
}
