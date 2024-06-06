output "secret_name" {
  description = "The name of the key pair"
  value       = aws_secretsmanager_secret.this.name
  sensitive   = true
}

output "secret_version_id" {
  description = "The key pair version"
  value       = aws_secretsmanager_secret.this.id
}

output "secret_string" {
  value = aws_secretsmanager_secret_version.this.secret_string
}
