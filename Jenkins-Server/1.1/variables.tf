# Variables
# Region
variable "aws_region" {
  default = "eu-west-3"
}

# Profile, used to authenticate to AWS.
# This is the profile name in ~/.aws/credentials
variable "aws_profile" {
  default = "terraform-course"
}

# Instance
variable "instance_name" {
  description = "Name of the instance to be created"
  default     = "terraform-demo1"
}

variable "instance_type" {
  default = "t3.medium"
}

variable "subnet_id" {
  description = "The VPC subnet the instance(s) will be created in"
  default     = "subnet-07ebbe60"
}

variable "ami_id" {
  description = "The AMI to use"
  default     = "ami-05b457b541faec0ca" # Ubuntu 22.04 LTS // eu-west-3
}

variable "number_of_instances" {
  description = "number of instances to be created"
  default     = 1
}

# VPC and subnet.

variable "cidr_vpc" {
  description = "CIDR block for the VPC"
  default     = "10.1.0.0/16"
}
variable "cidr_subnet" {
  description = "CIDR block for the subnet"
  default     = "10.1.0.0/24"
}
variable "availability_zone" {
  description = "availability zone to create subnet"
  default     = "eu-west-3a"
}
variable "public_key_path" {
  description = "Public key path"
  default     = "~/.ssh/id_rsa.pub"
}

variable "environment_tag" {
  description = "Environment tag"
  default     = "Production"
}

# Security group
variable "ingressports" {
  type    = list(number)
  default = [8080, 22]
}