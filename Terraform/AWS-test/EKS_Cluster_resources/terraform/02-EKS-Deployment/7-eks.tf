# This file is used to create the EKS cluster

resource "aws_iam_role" "my-demo" {
  name = "eks-cluster-my-demo"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "my-demo-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.my-demo.name
}

resource "aws_eks_cluster" "my-demo" {
  name     = var.cluster-name
  role_arn = aws_iam_role.my-demo.arn

  vpc_config {
    subnet_ids = [
      aws_subnet.private-subnet-region-a.id,
      aws_subnet.private-subnet-region-b.id,
      aws_subnet.public-subnet-region-a.id,
      aws_subnet.public-subnet-region-b.id
    ]
  }

  # This resource depends on the aws_iam_role_policy_attachment resource above to ensure that the IAM role is created before the EKS cluster is created.
  depends_on = [aws_iam_role_policy_attachment.my-demo-AmazonEKSClusterPolicy]
}

#      aws_subnet.public-us-east-1b.id
