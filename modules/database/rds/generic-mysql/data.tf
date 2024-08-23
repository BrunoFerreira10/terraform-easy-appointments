data "aws_ssm_parameter" "db_password" {
  name = "/github_secrets/${var.rds_configuration.ssm_parameter_db_password}"
}

## --------------------------------------------------------------------------------------------------------------------
## Get RDS private IP address
## --------------------------------------------------------------------------------------------------------------------
data "aws_network_interface" "rds_eni" {
  filter {
      name   = "description"
      values = ["RDSNetworkInterface"]
    }
}