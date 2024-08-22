module "app_ami" {
  source                    = "../modules/compute/ec2_image_builder/generic_ami_builder"
  app_repository_url        = module.data.github_vars.app_repository_url
  ec2_ssh_keypair_name      = module.data.github_vars.ec2_ssh_keypair_name
  region                    = module.data.github_vars.general_region
  shortname                 = module.data.github_vars.general_tag_shortname
  domain                    = module.data.github_vars.rt53_domain
  installation_parent_image = module.data.github_vars.image_builder_parent_image
  vpc                       = module.data.projects.vpc_app.vpc
  rds                       = module.data.projects.rds_mysql.rds
}
