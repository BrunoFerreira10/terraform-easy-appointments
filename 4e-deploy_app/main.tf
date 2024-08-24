module "build_app" {
  source                   = "../modules/developer/tools/generic_code_deploy"
  app_repository_url_https = module.data.github_vars.app_repository_url_https
  codebuild_settings = {
    project_name = "EasyAppointments"
    github_connection_name = module.data.github_vars.my_github_connection_name
  }
  
  project_bucket_name = module.data.github_vars.general_project_bucket_name
  region              = module.data.github_vars.general_region
  shortname           = module.data.github_vars.general_tag_shortname
}
