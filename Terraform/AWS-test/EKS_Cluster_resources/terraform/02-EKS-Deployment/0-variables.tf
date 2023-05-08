############################ Variables############################

# Region
variable "aws-region" {
  default = "eu-west-3"
}

##################################################

# Profile, used to authenticate to AWS.
# This is the profile name in ~/.aws/credentials
variable "aws-profile" {
  default = "terraform-course"
}

##################################################

# VPC.
variable "cidr-vpc" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16" # 65534 IPs
}

##################################################

#Subnets.
variable "cidr-private-subnet-a" {
  description = "CIDR block for the private subnet a"
  default     = "10.0.0.0/19" # 8190 IPs
}
variable "cidr-private-subnet-b" {
  description = "CIDR block for the private subnet b"
  default     = "10.0.32.0/19" # 8190 IPs
}

variable "cidr-public-subnet-a" {
  description = "CIDR block for the public ubnet a"
  default     = "10.0.64.0/19" # 8190 IPs
}
variable "cidr-public-subnet-b" {
  description = "CIDR block for the public subnet b"
  default     = "10.0.96.0/19" # 8190 IPs
}


##################################################

# EKS Cluster
variable "cluster-name" {
  default     = "my-demo"
  type        = string
  description = "AWS EKS CLuster Name"
  nullable    = false
}

##################################################

# Security Groups
variable "security-groups" {
  type = list(object({
    name        = string
    description = string
    ingress = object({
      description      = string
      protocol         = string
      from_port        = number
      to_port          = number
      cidr_blocks      = list(string)
      ipv6_cidr_blocks = list(string)
    })
  }))

  default = [{
    name        = "ssh"
    description = "Port 22"
    ingress = {
      description      = "Allow SSH access"
      protocol         = "tcp"
      from_port        = 22
      to_port          = 22
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = null
    }
    },
    {
      name        = "http"
      description = "Port 80"
      ingress = {
        description      = "Allow HTTP access"
        protocol         = "tcp"
        from_port        = 80
        to_port          = 80
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = null
      }
  }]

}


##################################################

# S3 Bucket name
variable "s3_tfstate" {
  type = object({
    bucket = string
  })
  default = {
    bucket = "my-demo-bucket-terraform-2021-06-28"
  }
}

##################################################

# DynamoDB table name
variable "dynamodb-lock" {
  type = object({
    table = string
  })
  default = {
    table = "terraform-state-locking"
  }
}




