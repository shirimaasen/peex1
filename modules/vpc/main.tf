resource "aws_vpc" "peex_vpc" {
  cidr_block = var.vpc_cidr_block

  lifecycle {
    ignore_changes = [
      cidr_block
    ]
  }

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "peex_subnet" {
  vpc_id                  = aws_vpc.peex_vpc.id
  cidr_block              = var.subnet_cidr_block
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet_name
  }
}

resource "aws_internet_gateway" "peex_igw" {
  vpc_id = aws_vpc.peex_vpc.id

  tags = {
    Name = var.igw_name
  }
}

resource "aws_route_table" "peex_route_table" {
  vpc_id = aws_vpc.peex_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.peex_igw.id
  }

  tags = {
    Name = var.route_table_name
  }
}

resource "aws_route_table_association" "peex-route-table-association" {
  subnet_id      = aws_subnet.peex_subnet.id
  route_table_id = aws_route_table.peex_route_table.id
}
