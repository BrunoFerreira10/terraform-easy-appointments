data "terraform_remote_state" "remote-state-vpc" {
  backend = "s3"
  config = {
    region = var.GENERAL_REGION
    bucket = var.GENERAL_REMOTE_STATE_BUCKET
    key    = "VPC Network/terraform.tfstate"
  }
}

data "terraform_remote_state" "s3_project" {
  backend = "s3"
  config = {
    region = var.GENERAL_REGION
    bucket = var.GENERAL_REMOTE_STATE_BUCKET
    key    = "S3_Project_Files/terraform.tfstate"
  }
}
