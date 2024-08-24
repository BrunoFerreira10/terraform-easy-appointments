module "build_app" {
  source = "../modules/developer/tools/generic_code_deploy"
  app_repository_url = module.data.github_vars.app_repository_url
  codebuild_settings = {
    project_name = "EasyAppointments"
  }
  github_connection = aws_codebuild_source_credential.github_app_connection
  project_bucket_name = module.data.general_project_bucket_name
  region = module.data.general_region
  shortname = module.data.general_tag_shortname
}