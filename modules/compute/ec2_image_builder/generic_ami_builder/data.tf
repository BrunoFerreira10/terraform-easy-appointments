data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

## TODO - Eliminar esse data.
data "aws_ssm_parameter" "db_password" {
  name = "/github_secrets/${var.rds.ssm_parameter_db_password}"
}