resource "aws_iam_role" "peex1-secret-role" {
  name = "peex1-secret-role"
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
}

resource "aws_iam_role_policy" "peex1-secret-policy" {
  name = "peex1-secret-policy"
  role = aws_iam_role.peex1-secret-role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "secretsmanager:GetSecretValue"
        ],
        Effect   = "Allow",
        Resource = "arn:aws:secretsmanager:eu-west-1:*:secret:mysql-credentials-*"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "peex1-secret-instance-profile" {
  name = "peex1-secret-instance-profile"
  role = aws_iam_role.peex1-secret-role.name
}

output "instance_profile_name" {
  value = aws_iam_instance_profile.peex1-secret-instance-profile.name
}