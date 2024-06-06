output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}

output "subnet_id" {
  description = "The ID of the subnet"
  value       = aws_subnet.this.id
}

# output "internet_gateway_id" {
#   description = "The ID of the Internet Gateway"
#   value       = aws_internet_gateway.this.id
# }

# output "route_table_id" {
#   description = "The ID of the Route Table"
#   value       = aws_route_table.this.id
# }
