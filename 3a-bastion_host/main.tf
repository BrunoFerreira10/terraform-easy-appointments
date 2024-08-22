module "bastion" {
  source               = "../modules/compute/ec2/bastion"
  ec2_ssh_keypair_name = module.data.github_vars.ec2_ssh_keypair_name
  region               = module.data.github_vars.general_region
  shortname            = module.data.github_vars.general_tag_shortname
  vpc                  = module.data.projects.vpc_app.vpc
}
