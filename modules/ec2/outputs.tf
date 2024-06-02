output "instance_id" {
  description = "The ID of the instance"
  value       = aws_instance.peex-secret-instance.id
}

output "public_ip" {
  description = "The public IP of the instance"
  value       = aws_instance.peex-secret-instance.public_ip
}
