data "aws_ami" "this" {
  most_recent = true
  filter {
    name   = "name"
    values = [var.ami_name]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = var.owners
}

resource "aws_security_group" "peex_sg" {
  name = var.sg_name
  description = "Allow HTTP and SSH traffic"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "peex_sg"
  }
}

resource "aws_network_interface" "peex-network-interface" {
  subnet_id       = var.subnet_id
  private_ips     = [var.private_ip]
  security_groups = [aws_security_group.peex_sg.id]
}

resource "aws_eip" "peex-eip" {
  network_interface         = aws_network_interface.peex-network-interface.id
  associate_with_private_ip = var.private_ip
}

resource "aws_instance" "peex-secret-instance" {
  ami                  = data.aws_ami.this.id
  instance_type        = var.instance_type
  key_name             = var.key_pair_name
  iam_instance_profile = var.iam_instance_profile
  network_interface {
    network_interface_id = aws_network_interface.peex-network-interface.id
    device_index         = 0
  }
  user_data = var.user_data
  tags = var.tags

  depends_on = [
    var.key_pair_version,
    aws_eip.peex-eip
  ]
}