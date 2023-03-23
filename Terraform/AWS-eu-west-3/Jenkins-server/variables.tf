#variable "access_key" {
#        description = "Access key to AWS console"
#}
#variable "secret_key" {
#        description = "Secret key to AWS console"
#}


variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "eu-west-3"
}

variable "instance_name" {
        description = "Name of the instance to be created"
        default = "jenkins-server"
}

variable "instance_type" {
        default = "t2.micro"
}

variable "subnet_id" {
        description = "The VPC subnet the instance(s) will be created in"
        default = "subnet-0c14d6f156aa2cb88"
}

variable "ami_id" {
        description = "The AMI to use"
        default = "ami-05b457b541faec0ca"
}

variable "number_of_instances" {
        description = "number of instances to be created"
        default = 1
}


variable "ami_key_pair_name" {
        default = "Budgie-Paris"
}
