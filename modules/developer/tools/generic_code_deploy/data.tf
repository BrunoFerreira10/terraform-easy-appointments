

data "aws_caller_identity" "current" {}

data "aws_ssm_parameter" "github_token" {
  name = "/github_secrets/github_token"
}

data "aws_codestarconnections_connection" "github_app_connection" {
  name = var.codebuild_settings.github_connection_name
}

data "aws_ssm_parameter" "db_password" {
  name = "/github_secrets/${var.rds.ssm_parameter_db_password}"
}