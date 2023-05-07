output "vpc_id" {
  value       = aws_vpc.eks-main.id
  description = "This is the vpc id: "
}

output "enable_dns_hostnames" {
  value       = aws_vpc.eks-main.enable_dns_hostnames
  description = "This is the enable_dns_hostnames: "
}

output "enable_dns_support" {
  value       = aws_vpc.eks-main.enable_dns_support
  description = "This is the enable_dns_support: "

}
output "aws_interntet_gateway" {
  value       = aws_internet_gateway.eks-igw.id
  description = "This is the aws_interntet_gateway: "
}

output "igw_aws_account_id" {
  value       = aws_internet_gateway.eks-igw.owner_id
  description = "This is the igw_aws_account_id: "
}

output "nat_gateway_id" {
  value       = aws_nat_gateway.nat.id
  description = "This is the nat_gateway_id: "
}

output "nat_gateway_public_ip" {
  value       = aws_nat_gateway.nat.public_ip
  description = "This is the nat_gateway_public_ip: "
}


# output "public_subnets" {
#   value = ["${aws_subnet.subnet_public.id}"]
# }
# output "public_route_table_ids" {
#   value = ["${aws_route_table.rtb_public.id}"]
# }
# output "public_instance_ip" {
#   value = ["${aws_instance.ec2_instance.public_ip}"]
# }
# 
# # Imprime la url de jenkins para conectarnos // print the url of the jenkins server / 
# output "website_url" {
#   value = join("", ["http://", aws_instance.ec2_instance.public_dns, ":", "8080"])
# }
# 
# 