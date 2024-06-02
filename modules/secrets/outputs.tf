output "peex_secret_id" {
  description = "The ID of the MySQL credentials secret"
  value       = aws_secretsmanager_secret.peex_creds.id
}

output "peex_key_pair_name" {
  description = "The name of the key pair"
  value       = local.key_pair_name
}