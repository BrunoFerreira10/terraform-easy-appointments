module "elb_app" {
  source               = "../modules/compute/ec2/generic_elb"
  acm_certificate      = module.data.projects.acm_ssl.certificate
  domain               = module.data.github_vars.rt53_domain
  ec2_ssh_keypair_name = module.data.github_vars.ec2_ssh_keypair_name
  image_ami            = module.data.projects.app_ami.golden_image
  shortname            = module.data.github_vars.general_tag_shortname
  vpc                  = module.data.projects.vpc_app.vpc
}