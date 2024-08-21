output "rds" {
  description = "RDS MySQL Information"
  value = {
    id       = aws_db_instance.rds.id,
    arn      = aws_db_instance.rds.arn,
    endpoint = split(":", aws_db_instance.rds.endpoint)[0],
    port     = aws_db_instance.rds.port
  }
}