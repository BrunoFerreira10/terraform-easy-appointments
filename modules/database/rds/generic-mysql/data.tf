data "aws_ssm_parameter" "db_password" {
  name = "/github_secrets/${var.rds_configuration.ssm_parameter_db_password}"
}