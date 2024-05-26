resource "aws_vpc" "peex1-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "peex1-vpc"
  }
}

resource "aws_internet_gateway" "peex1-igw" {
  vpc_id = aws_vpc.peex1-vpc.id
  tags = {
    Name = "peex1-igw"
  }
}

resource "aws_route_table" "peex1-route-table" {
  vpc_id = aws_vpc.peex1-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.peex1-igw.id
  }
  tags = {
    Name = "peex1-route-table"
  }
}

resource "aws_route_table_association" "peex1-route-table-association" {
  subnet_id      = aws_subnet.peex1-subnet.id
  route_table_id = aws_route_table.peex1-route-table.id
}

resource "aws_subnet" "peex1-subnet" {
  vpc_id                 = aws_vpc.peex1-vpc.id
  cidr_block             = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "peex1-subnet"
  }
}