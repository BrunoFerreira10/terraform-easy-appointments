module "lightsail_app_domain" {
  source               = "../modules/compute/lightsail/generic_lightsail_hosted_zone"
  domain               = module.data.github_vars.rt53_domain
  shortname            = module.data.github_vars.general_tag_shortname
}

