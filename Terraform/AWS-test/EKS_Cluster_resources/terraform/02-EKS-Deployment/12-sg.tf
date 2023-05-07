# This file asociates the security groups to the VPC
# resource "aws_security_group" "eks-main-sg" {
#   name        = "eks-main-sg"
#   description = "EKS Main Security Group"
#   vpc_id      = aws_vpc.eks-main.id
#
#   dynamic "ingress" { 
#     for_each = var.security-groups[0].ingress
#     content {
#       description      = ingress.value.description
#       from_port        = ingress.value.from_port
#       to_port          = ingress.value.to_port
#       protocol         = ingress.value.protocol
#       cidr_blocks      = ingress.value.cidr_blocks
#       ipv6_cidr_blocks = ingress.value.ipv6_cidr_blocks
#     }
#   }
#
#   tags = {
#     Name        = "eks-main-sg"
#     Description = "EKS Main Security Group"
#     Terraform   = "true"
#   }
# }
#
# resource "aws_security_group" "eks-node" {
#   name        = "eks-node"
#   description = "EKS Node Security Group"
#   vpc_id      = aws_vpc.eks-main.id
#
#   dynamic "ingress" {
#     for_each = var.security-groups[1].ingress
#     content {
#       description      = ingress.value.description
#       from_port        = ingress.value.from_port
#       to_port          = ingress.value.to_port
#       protocol         = ingress.value.protocol
#       cidr_blocks      = ingress.value.cidr_blocks
#       ipv6_cidr_blocks = ingress.value.ipv6_cidr_blocks
#     }
#   }
#
#   tags = {
#     Name        = "eks-node"
#     Description = "EKS Node Security Group"
#     Terraform   = "true"
#   }
# }
#
