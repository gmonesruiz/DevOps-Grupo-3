terraform {
################# Se da por hecho que los recursos en s3 ya estan creados ################
  backend "s3" {
    bucket         = "grupo-3-dev-cluster" # REEMPLAZAR CON EL NOMBRE DEL BUCKET NECESARIO
    key            = "grupo-3-dev-cluster/import-bootstrap/terraform.tfstate"
    region         = "eu-west-3"
    dynamodb_table = "terraform-state-locking"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-west-3"
}

data "aws_availability_zones" "available" {}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

locals {
  cluster_name = "grupo-3-dev-cluster"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

module "eks-kubeconfig" {
  source  = "hyperbadger/eks-kubeconfig/aws"
  version = "1.0.0"

  depends_on = [module.eks]
  cluster_id = module.eks.cluster_id
  tags = {
    "Terraform"   = "true"
    "Environment" = "dev"
  }
}

resource "local_file" "kubeconfig" {
  content  = module.eks-kubeconfig.kubeconfig
  filename = "kubeconfig_${local.cluster_name}"
}

#################### Se crea la VPC con dos zonas de disponibilidad ###################3

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.18.1"

  name                 = "grupo3-dev-vpc"
  cidr                 = "10.1.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["10.1.3.0/24", "10.1.4.0/24"]
  public_subnets       = ["10.1.1.0/24", "10.1.2.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
  tags = {
    "Terraform"   = "true"
    "Environment" = "dev"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.30.3"

  cluster_name    = local.cluster_name
  cluster_version = "1.24"
  subnet_ids      = module.vpc.private_subnets

  vpc_id = module.vpc.vpc_id

  eks_managed_node_groups = {
    first = {
      desired_capacity = 1
      max_capacity     = 10
      min_capacity     = 1

      instance_type = "t2.micro"
    }
  }
  tags = {
    "Terraform"   = "true"
    "Environment" = "dev"
  }
}

resource "aws_iam_policy" "worker_policy" {
  name        = "worker-policy-dev"
  description = "Worker policy for the ALB Ingress"

  policy = file("iam-policy.json")
}

resource "aws_iam_role_policy_attachment" "additional" {
  for_each = module.eks.eks_managed_node_groups

  policy_arn = aws_iam_policy.worker_policy.arn
  role       = each.value.iam_role_name
}
