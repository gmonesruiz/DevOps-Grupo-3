# This file creates the VPC for the EKS cluster

resource "aws_vpc" "eks-main" {
  cidr_block = var.cidr-vpc


  tags = {
    Name        = "eks-main"
    Description = "EKS VPC"
    Terraform   = "true"
  }
}
