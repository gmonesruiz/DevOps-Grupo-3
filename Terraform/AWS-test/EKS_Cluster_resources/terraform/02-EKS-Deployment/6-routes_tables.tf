# This file is used to create the route tables for the EKS cluster

# This file is used to create the route tables for the EKS cluster

resource "aws_route_table" "eks-private" {
  vpc_id = aws_vpc.eks-main.id

  route = [{
    cidr_block                 = "0.0.0.0/0"
    gateway_id                 = aws_internet_gateway.eks-igw.id
    nat_gateway_id             = ""
    carrier_gateway_id         = ""
    destination_prefix_list_id = ""
    egress_only_gateway_id     = ""
    instance_id                = ""
    ipv6_cidr_block            = ""
    local_gateway_id           = ""
    network_interface_id       = ""
    transit_gateway_id         = ""
    vpc_endpoint_id            = ""
    vpc_peering_connection_id  = ""
    },
  ]
  tags = {
    Name      = "eks-private"
    Terraform = "true"
  }
}

resource "aws_route_table" "eks-public" {
  vpc_id = aws_vpc.eks-main.id

  route = [{
    cidr_block                 = "0.0.0.0/0"
    gateway_id                 = aws_internet_gateway.eks-igw.id
    nat_gateway_id             = ""
    carrier_gateway_id         = ""
    destination_prefix_list_id = ""
    egress_only_gateway_id     = ""
    instance_id                = ""
    ipv6_cidr_block            = ""
    local_gateway_id           = ""
    network_interface_id       = ""
    transit_gateway_id         = ""
    vpc_endpoint_id            = ""
    vpc_peering_connection_id  = ""
    },
  ]
  tags = {
    Name      = "eks-public"
    Terraform = "true"
  }
}

resource "aws_route_table_association" "eks-private-region-a" {
  subnet_id      = aws_subnet.private-subnet-region-a.id
  route_table_id = aws_route_table.eks-private.id
}

resource "aws_route_table_association" "eks-private-region-b" {
  subnet_id      = aws_subnet.private-subnet-region-b.id
  route_table_id = aws_route_table.eks-private.id
}

resource "aws_route_table_association" "eks-public-region-a" {
  subnet_id      = aws_subnet.public-subnet-region-a.id
  route_table_id = aws_route_table.eks-public.id
}

resource "aws_route_table_association" "eks-public-region-b" {
  subnet_id      = aws_subnet.public-subnet-region-b.id
  route_table_id = aws_route_table.eks-public.id
}

