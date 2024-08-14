terraform {
  required_version = ">= 1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.40.0"
    }
  }
  backend "s3" {}
}

provider "aws" {
  region = var.GENERAL_REGION

  default_tags {
    tags = {
      "owner"      = var.GENERAL_TAG_AUTHOR
      "project"    = var.GENERAL_TAG_PROJECT
      "customer"   = var.GENERAL_TAG_CUSTOMER
      "managed-by" = "terraform"
    }
  }
}

module "ec2-setup" {
  source               = "./ec2-setup"
  region               = var.GENERAL_REGION
  remote-state-bucket  = var.GENERAL_REMOTE_STATE_BUCKET
  EC2_SSH_KEYPAIR_NAME = var.EC2_SSH_KEYPAIR_NAME
  shortname            = var.GENERAL_TAG_SHORTNAME
  RT53_DOMAIN          = var.RT53_DOMAIN
}