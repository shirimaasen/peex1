resource "random_password" "peex_passwd" {
  length  = var.passwd_len
  special = true
}

resource "aws_secretsmanager_secret" "peex_creds" {
  name        = var.peex_creds
  description = var.peex_creds_desc

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_secretsmanager_secret_version" "peex_creds_version" {
  secret_id     = aws_secretsmanager_secret.peex_creds.id
  secret_string = jsonencode({
    username = var.username,
    password = random_password.peex_passwd.result
  })
}

resource "aws_secretsmanager_secret" "peex_key_pair" {
  name        = var.peex_key_pair_name
  description = var.peex_key_pair_desc

  lifecycle {
    prevent_destroy = true
  }

}

resource "aws_secretsmanager_secret_version" "peex_key_pair_version" {
  secret_id     = aws_secretsmanager_secret.peex_key_pair.id
  secret_string = jsonencode({
    key = var.peex_key_pair_value
  })
}

data "aws_secretsmanager_secret" "peex_key_pair" {
  name = aws_secretsmanager_secret.peex_key_pair.name
}

data "aws_secretsmanager_secret_version" "peex_key_pair_version" {
  secret_id = data.aws_secretsmanager_secret.peex_key_pair.id
}

locals {
  key_pair_name = jsondecode(data.aws_secretsmanager_secret_version.peex_key_pair_version.secret_string).key
}