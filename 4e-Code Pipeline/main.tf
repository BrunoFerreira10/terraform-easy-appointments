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

module "code-pipeline" {
  source                      = "./code-pipeline"
  GENERAL_REGION              = var.GENERAL_REGION
  GENERAL_PROJECT_BUCKET = var.GENERAL_PROJECT_BUCKET
  GENERAL_TAG_SHORTNAME       = var.GENERAL_TAG_SHORTNAME
}
