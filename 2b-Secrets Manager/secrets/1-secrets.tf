# Sincroniza github secrets com aws secret manager
resource "aws_secretsmanager_secret" "secrets" {
  for_each = var.GITHUB_SECRETS
  name     = each.key
}

resource "aws_secretsmanager_secret_version" "secrets-version" {
  for_each      = var.GITHUB_SECRETS
  secret_id     = aws_secretsmanager_secret.secrets[each.key].id
  secret_string = each.value
}

# Cria politicas para cada secret no secret manager.
resource "aws_iam_policy" "secrets-policy" {
  for_each = var.GITHUB_SECRETS
  name     = "iam-policy-${each.key}"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "secretsmanager:GetSecretValue"
        ],
        Resource = aws_secretsmanager_secret.secrets[each.key].arn
      }
    ],
  })
}
