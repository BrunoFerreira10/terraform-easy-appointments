module "data" {
  source = "../modules/data"
  requested_data = [
    "lightsail_app_domain"
  ]
}