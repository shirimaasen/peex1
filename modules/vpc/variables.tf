variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "subnet_cidr_block" {
  description = "The CIDR block for the subnet"
  type        = string
}

variable "vpc_name" {
  description = "The name for the VPC"
  type        = string
}

variable "subnet_name" {
  description = "The name for the subnet"
  type        = string
}

variable "igw_name" {
  description = "The name for the internet gateway"
  type        = string
}

variable "route_table_name" {
  description = "The name for the route table"
  type        = string
}
