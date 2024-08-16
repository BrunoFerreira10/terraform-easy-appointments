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

module "s3_project_files" {
  source                      = "./s3_project_files"
  GENERAL_TAG_SHORTNAME       = var.GENERAL_TAG_SHORTNAME
  GENERAL_REGION              = var.GENERAL_REGION
  GENERAL_REMOTE_STATE_BUCKET = var.GENERAL_REMOTE_STATE_BUCKET
  S3_LOGGING_BUCKET_NAME      = var.S3_LOGGING_BUCKET_NAME
}