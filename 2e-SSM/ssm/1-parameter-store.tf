# Sincroniza github secrets com aws secret manager
resource "aws_ssm_parameter" "ssm-secrets" {
  for_each = var.GITHUB_SECRETS
  name     = each.key
  type     = "SecureString"
  value    = each.value
}