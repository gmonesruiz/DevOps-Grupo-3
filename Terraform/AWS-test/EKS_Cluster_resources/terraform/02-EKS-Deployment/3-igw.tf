# Terraform managed VPC Internet Gateway, to allow access to the internet
resource "aws_internet_gateway" "eks-igw" {
  vpc_id = aws_vpc.eks-main.id #This is the VPC ID created in the previous step, and it's attached to the IGW

  tags = {
    Name        = "eks-igw"
    Description = "EKS IGW"
    Terraform   = "true"
  }
}
