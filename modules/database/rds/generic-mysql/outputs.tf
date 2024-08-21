output "rds" {
  description = "RDS MySQL Information"
  value = {
    id                        = aws_db_instance.rds.id,
    arn                       = aws_db_instance.rds.arn,
    endpoint                  = split(":", aws_db_instance.rds.endpoint)[0],
    port                      = aws_db_instance.rds.port,
    db_name                   = aws_db_instance.rds.db_name
    db_username               = aws_db_instance.rds.username
    ssm_parameter_db_password = var.rds_configuration.ssm_parameter_db_password
  }
}
