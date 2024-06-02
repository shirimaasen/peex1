output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.peex_vpc.id
}

output "subnet_id" {
  description = "The ID of the subnet"
  value       = aws_subnet.peex_subnet.id
}

output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.peex_igw.id
}

output "route_table_id" {
  description = "The ID of the Route Table"
  value       = aws_route_table.peex_route_table.id
}
