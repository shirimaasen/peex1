resource "random_password" "mysql_password" {
  length  = 16
  special = true
}

resource "aws_secretsmanager_secret" "mysql_credentials" {
  name        = "mysql-credentials"
  description = "MySQL credentials"
}

resource "aws_secretsmanager_secret_version" "mysql_credentials_version" {
  secret_id     = aws_secretsmanager_secret.mysql_credentials.id
  secret_string = jsonencode({
    username = "admin",
    password = random_password.mysql_password.result
  })
}

resource "aws_secretsmanager_secret" "peex-key-pair" {
  name        = "peex-key-pair"
  description = "Key Pair Name for EC2"
}

resource "aws_secretsmanager_secret_version" "peex-key-pair-version" {
  secret_id     = aws_secretsmanager_secret.peex-key-pair.id
  secret_string = jsonencode({
    key = "peex"
  })
}

data "aws_secretsmanager_secret" "peex-key-pair" {
  name = aws_secretsmanager_secret.peex-key-pair.name
}

data "aws_secretsmanager_secret_version" "peex-key-pair-version" {
  secret_id = data.aws_secretsmanager_secret.peex-key-pair.id
}

locals {
  key_pair_name = jsondecode(data.aws_secretsmanager_secret_version.peex-key-pair-version.secret_string).key
}