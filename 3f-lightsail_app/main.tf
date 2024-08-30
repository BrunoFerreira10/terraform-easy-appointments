module "lightsail_app" {
  source               = "../modules/compute/lightsail/generic_lightsail_instance"
  domain               = module.data.github_vars.rt53_domain
  ec2_ssh_keypair_name = module.data.github_vars.ec2_ssh_keypair_name
  lightsail_static_ip  = module.data.projects.lightsail_app_domain.lightsail_static_ip
  lightsail_tag_name   = module.data.github_vars.lightsail_tag_name
  project_bucket_name  = module.data.github_vars.general_project_bucket_name
  shortname            = module.data.github_vars.general_tag_shortname
  region               = module.data.github_vars.general_region
}

