# This file creates the NAT Gateway for the EKS cluster

resource "aws_eip" "nat" {
  vpc = true

  tags = {
    Name      = "nat"
    Terraform = "true"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public-subnet-a.id
  tags = {
    Name      = "nat-gw"
    Terraform = "true"
  }
  # Here we are telling Terraform that the NAT Gateway depends on the Internet Gateway, so that it will create the IGW first
  depends_on = [aws_internet_gateway.eks-igw]
}



