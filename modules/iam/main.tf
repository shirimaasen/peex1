resource "aws_iam_role" "peex-secret-role" {
  name = var.role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })

  lifecycle {
    create_before_destroy = true
    ignore_changes = [name]
  }
}

resource "aws_iam_role_policy" "peex-secret-policy" {
  name = var.policy_name
  role = aws_iam_role.peex-secret-role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "secretsmanager:GetSecretValue"
        ],
        Effect   = "Allow",
        Resource = var.secret_arn
      }
    ]
  })
}

resource "aws_iam_instance_profile" "peex-secret-instance-profile" {
  name = var.instance_profile_name
  role = aws_iam_role.peex-secret-role.name

  lifecycle {
    create_before_destroy = true
    ignore_changes = [name]
  }
}

output "instance_profile_name" {
  value = aws_iam_instance_profile.peex-secret-instance-profile.name
}