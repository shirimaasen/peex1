output "peex_secret_id" {
  description = "The ID of the MySQL credentials secret"
  value       = aws_secretsmanager_secret.peex_creds.id
}

output "peex_key_pair_name" {
  description = "The name of the key pair"
  value       = aws_secretsmanager_secret.peex_key_pair.name
}

output "peex_key_pair_version" {
  description = "The key pair version"
  value       = aws_secretsmanager_secret.peex_key_pair.id
}