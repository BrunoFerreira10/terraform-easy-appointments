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

module "rds" {
  source                      = "./rds"
  GENERAL_REGION              = var.GENERAL_REGION
  GENERAL_REMOTE_STATE_BUCKET = var.GENERAL_REMOTE_STATE_BUCKET
  GENERAL_TAG_SHORTNAME       = var.GENERAL_TAG_SHORTNAME
  RDS_1_DB_NAME               = var.RDS_1_DB_NAME
  RDS_1_DB_USERNAME           = var.RDS_1_DB_USERNAME
  RDS_1_DB_PASSWORD           = var.RDS_1_DB_PASSWORD
}
