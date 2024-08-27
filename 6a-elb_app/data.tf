module "data" {
  source = "../modules/data"
  requested_data = [
    "vpc_app",
    "acm_app",
    "rds_app",
    "efs_app",
    "img_builder_app"
  ]
}