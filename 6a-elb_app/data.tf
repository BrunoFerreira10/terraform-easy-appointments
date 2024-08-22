module "data" {
  source = "../modules/data"
  requested_data = [
    "vpc_app",
    "acm_app",
    "ami_app"
  ]
}