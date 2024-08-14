data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

data "aws_ssm_parameter" "RDS_1_DB_PASSWORD" {
  name = "RDS_1_DB_PASSWORD"
}

data "terraform_remote_state" "remote-state-vpc" {
  backend = "s3"
  config = {
    region = var.region
    bucket = var.remote-state-bucket
    key    = "VPC Network/terraform.tfstate"
  }
}

data "terraform_remote_state" "remote-state-rds" {
  backend = "s3"
  config = {
    region = var.region
    bucket = var.remote-state-bucket
    key    = "RDS Database/terraform.tfstate"
  }
}

data "terraform_remote_state" "remote-s3-logging" {
  backend = "s3"
  config = {
    region = var.region
    bucket = var.remote-state-bucket
    key    = "S3 Logging/terraform.tfstate"
  }
}