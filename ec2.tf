data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

resource "aws_network_interface" "peex1-network-interface" {
  subnet_id       = aws_subnet.peex1-subnet.id
  private_ips     = ["10.0.1.50"]
  security_groups = [aws_security_group.peex1-sg.id]
}

resource "aws_eip" "peex1-eip" {
  network_interface         = aws_network_interface.peex1-network-interface.id
  associate_with_private_ip = "10.0.1.50"
}

resource "aws_instance" "peex1-secret-instance" {
  ami                  = data.aws_ami.ubuntu.id
  instance_type        = "t2.micro"
  key_name             = local.key_pair_name
  iam_instance_profile = aws_iam_instance_profile.peex1-secret-instance-profile.name
  network_interface {
    network_interface_id = aws_network_interface.peex1-network-interface.id
    device_index         = 0
  }
  user_data = file("get_secret.sh")
  tags = {
    Name = "peex1-secret-instance"
  }

  depends_on = [
    aws_secretsmanager_secret_version.peex-key-pair-version,
    aws_eip.peex1-eip
  ]
}