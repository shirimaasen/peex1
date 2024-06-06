data "aws_ami" "this" {
  most_recent = true
  filter {
    name   = "virtualization-type"
    values = [var.virtualization_type]
  }
  filter {
    name   = "name"
    values = [var.ami_name]
  }
  owners      = var.owners
}

resource "aws_security_group" "this" {
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
    Name = var.sg_tag
  }
}

resource "aws_network_interface" "this" {
  subnet_id       = var.subnet_id
  private_ips     = [var.private_ip]
  security_groups = [aws_security_group.this.id]
}

resource "aws_eip" "this" {
  network_interface         = aws_network_interface.this.id
  associate_with_private_ip = var.private_ip
}

resource "aws_instance" "this" {
  ami                  = data.aws_ami.this.id
  instance_type        = var.instance_type
  key_name             = var.key_name
  iam_instance_profile = var.iam_instance_profile
  network_interface {
    network_interface_id = aws_network_interface.this.id
    device_index         = 0
  }
  user_data = var.user_data
  tags = var.ec2_tags

  depends_on = [
    var.key_name,
    aws_eip.this
  ]
}

resource "aws_iam_instance_profile" "this" {
  name = var.instance_profile_name
  role = var.role_name

  lifecycle {
    ignore_changes = [name]
  }
}
