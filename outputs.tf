output "instance_public_dns" {
  value = aws_instance.peex1-secret-instance.public_dns
}

output "instance_public_ip" {
  value = aws_instance.peex1-secret-instance.public_ip
}