output "public_ip" {
  description = "The public IP of the instance"
  value       = module.ec2_instance.public_ip
}