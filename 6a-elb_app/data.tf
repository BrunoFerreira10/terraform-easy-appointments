module "data" {
  source = "../modules/data"
  requested_data = [
    "vpc_app",
    "acm_ssl",
    "app_ami"
  ]
}