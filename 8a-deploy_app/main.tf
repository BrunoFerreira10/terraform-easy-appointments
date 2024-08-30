module "deploy_app" {
  source                   = "../modules/developer/tools/generic_lightsail_codedeploy"
  app_repository_url_https = module.data.github_vars.app_repository_url_https
  codebuild_settings = { # TODO - Rever essa divisão
    project_name = "EasyAppointments"
    github_connection_name = module.data.github_vars.my_github_connection_name
  }
  codedeploy_settings = { # TODO - Rever essa divisão
    application_name = "EasyAppointments"
  }
  domain              = module.data.github_vars.rt53_domain
  lightsail_tag_name  = module.data.github_vars.lightsail_tag_name
  project_bucket_name = module.data.github_vars.general_project_bucket_name
  region              = module.data.github_vars.general_region
  shortname           = module.data.github_vars.general_tag_shortname
}
