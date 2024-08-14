data "aws_ssm_parameter" "RDS_1_DB_PASSWORD" {
  name = "RDS_1_DB_PASSWORD"
}

data "terraform_remote_state" "remote-state-vpc" {
  backend = "s3"
  config = {
    region = var.GENERAL_REGION
    bucket = var.GENERAL_REMOTE_STATE_BUCKET
    key    = "VPC Network/terraform.tfstate"
  }
}