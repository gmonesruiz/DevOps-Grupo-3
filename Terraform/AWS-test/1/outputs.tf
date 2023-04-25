output "vpc_id" {
  value       = aws_vpc.VPC-test1.id
  description = "This is the vpc id: "
}

output "enable_dns_hostnames" {
  value       = aws_vpc.VPC-test1.enable_dns_hostnames
  description = "This is the enable_dns_hostnames: "
}

output "enable_dns_support" {
  value       = aws_vpc.VPC-test1.enable_dns_support
  description = "This is the enable_dns_support: "

}
output "aws_interntet_gateway" {
  value       = aws_internet_gateway.igw-test1.id
  description = "This is the aws_interntet_gateway: "
}

output "igw_aws_account_id" {
  value       = aws_internet_gateway.igw-test1.owner_id
  description = "This is the igw_aws_account_id: "
}

output "public_subnets" {
  value = ["${aws_subnet.subnet_public.id}"]
}
output "public_route_table_ids" {
  value = ["${aws_route_table.rtb_public.id}"]
}
output "public_instance_ip" {
 value = ["${aws_instance.ec2_instance.public_ip}"]
}
