data "terraform_remote_state" "remote-state-vpc" {
  backend = "s3"
  config = {
    region = var.region
    bucket = var.remote-state-bucket
    key    = "VPC Network/terraform.tfstate"
  }
}