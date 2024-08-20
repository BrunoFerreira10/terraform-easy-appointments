## --------------------------------------------------------------------------------------------------------------------
## Github Varibles - Only unsecure values
## --------------------------------------------------------------------------------------------------------------------
data "aws_ssm_parameters_by_path" "github_vars" {
  path           = "/github_vars"
  recursive      = true
  with_decryption = true
}

locals {
  names_split = [
    for name in data.aws_ssm_parameters_by_path.github_vars.names :
    split("/",substr(name, 1, -1))[1]
  ] 

  github_vars = zipmap(
    local.names_split,
    data.aws_ssm_parameters_by_path.github_vars.values,
  )
}
## --------------------------------------------------------------------------------------------------------------------
## Data: VPC App
## --------------------------------------------------------------------------------------------------------------------
# data "terraform_remote_state" "vpc_app" {
#   count = contains(var.requested_data,"vpc_app") ? 1 : 0
  
#   backend = "s3"
#   config = {
#     region = local.github_vars.general_region
#     bucket = local.github_vars.general_project_bucket_name
#     key    = "remote_states/vpc_app/terraform.tfstate"
#   }
# }

# data "terraform_remote_state" "rds" {
#   count = contains(var.requested_data,"rds") ? 1 : 0
  
#   backend = "s3"
#   config = {
#     region = local.github_vars.general_region
#     bucket = local.github_vars.general_project_bucket_name
#     key    = "remote_states/rds/terraform.tfstate"
#   }
# }

data "terraform_remote_state" "remote_states" {
  
  for_each = toset(var.requested_data)

  backend = "s3"
  config = {
    region = local.github_vars.general_region
    bucket = local.github_vars.general_project_bucket_name
    key    = "remote_states/${each.value}/terraform.tfstate"
  }
}

locals {
  remote_states = nonsensitive(data.terraform_remote_state.remote_states)
}

output "projects" {
  description = "Return requested projects remote states."
  value = nonsensitive(local.remote_states)
}

# locals {
#   projects = merge(
#     contains(var.requested_data, "vpc_app") ? {
#       "vpc_app" = data.terraform_remote_state.vpc_app[0].outputs
#     } : {},
#     contains(var.requested_data, "rds") ? {
#       "rds" = data.terraform_remote_state.rds[0].outputs
#     } : {}
#   )
# }



