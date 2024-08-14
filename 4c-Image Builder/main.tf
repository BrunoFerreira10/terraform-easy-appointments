terraform {
  required_version = ">= 1.9.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.62.0"
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

module "image-builder-1" {
  source                     = "./image-builder-1"
  region                     = var.GENERAL_REGION
  remote-state-bucket        = var.GENERAL_REMOTE_STATE_BUCKET
  shortname                  = var.GENERAL_TAG_SHORTNAME
  RT53_DOMAIN                = var.RT53_DOMAIN
  EC2_SSH_KEYPAIR_NAME       = var.EC2_SSH_KEYPAIR_NAME
  IMAGE_BUILDER_PARENT_IMAGE = var.IMAGE_BUILDER_PARENT_IMAGE
}