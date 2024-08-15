data "terraform_remote_state" "remote-state-vpc" {
  backend = "s3"
  config = {
    region = var.region
    bucket = var.remote-state-bucket
    key    = "VPC Network/terraform.tfstate"
  }
}

# data "terraform_remote_state" "remote-ami" {
#   backend = "s3"
#   config = {
#     region = var.region
#     bucket = var.remote-state-bucket
#     key    = "AMI Setup/terraform.tfstate"
#     # key    = "AMI Update/terraform.tfstate"
#   }
# }

data "terraform_remote_state" "remote-image-builder" {
  backend = "s3"
  config = {
    region = var.region
    bucket = var.remote-state-bucket
    key    = "Image Builder/terraform.tfstate"
  }
}


data "terraform_remote_state" "remote-ssl-certificate" {
  backend = "s3"
  config = {
    region = var.region
    bucket = var.remote-state-bucket
    key    = "ACM-SSL/terraform.tfstate"
  }
}