# This file creates the private subnets for the EKS cluster

# Private subnets are used for the worker nodes, and they are not accessible from the internet
resource "aws_subnet" "private-subnet-a" {
  vpc_id            = aws_vpc.eks-main.id
  cidr_block        = var.cidr-private-subnet-a
  availability_zone = "${var.aws-region}a"

  tags = {
    Name                              = "private-${var.aws-region}a"
    Terraform                         = "true"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/my-demo"   = "owned"
  }
}

resource "aws_subnet" "private-subnet-b" {
  vpc_id            = aws_vpc.eks-main.id
  cidr_block        = var.cidr-private-subnet-b
  availability_zone = "${var.aws-region}b"


  tags = {
    Name                              = "private-${var.aws-region}b"
    Terraform                         = "true"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/my-demo"   = "owned"
  }
}

##############################################

# Public subnets
resource "aws_subnet" "public-subnet-a" {
  vpc_id                  = aws_vpc.eks-main.id
  cidr_block              = var.cidr-public-subnet-a
  availability_zone       = "${var.aws-region}a"
  map_public_ip_on_launch = true

  tags = {
    Name                              = "public-${var.aws-region}a"
    Terraform                         = "true"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/my-demo"   = "owned"
  }
}

resource "aws_subnet" "public-subnet-b" {
  vpc_id                  = aws_vpc.eks-main.id
  cidr_block              = var.cidr-public-subnet-b
  availability_zone       = "${var.aws-region}b"
  map_public_ip_on_launch = true

  tags = {
    Name                              = "public-${var.aws-region}b"
    Terraform                         = "true"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/my-demo"   = "owned"
  }
}
