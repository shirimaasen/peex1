resource "aws_secretsmanager_secret" "this" {
  name        = var.secret_name
  description = var.secret_description

  lifecycle {
    ignore_changes = [name, description]
  }
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = var.secret_string

  lifecycle {
    ignore_changes = [ secret_string ]
  }
}

resource "aws_secretsmanager_secret_version" "ignore_changes" {
  count = var.lifecycle_ignore_changes ? 1 : 0
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = var.secret_string

  lifecycle {
    ignore_changes = [ secret_string ]
  }
}
