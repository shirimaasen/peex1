output "public_ip" {
  description = "The public IP of the instance"
  value       = module.ec2.public_ip
}