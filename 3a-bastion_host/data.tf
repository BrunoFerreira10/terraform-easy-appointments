module "data" {
  source              = "../modules/data"
  requested_data  = [
    "vpc_app"
  ]
}

locals {
  projects = nonsensitive(module.data.projects)
}

output "projects" {
  value = nonsensitive(local.projects)
}
