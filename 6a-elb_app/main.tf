module "elb_app" {
  source               = "../modules/compute/ec2/generic_elb"
  acm_certificate      = module.data.projects.acm_app.certificate
  domain               = module.data.github_vars.rt53_domain
  ec2_ssh_keypair_name = module.data.github_vars.ec2_ssh_keypair_name
  ami_image_id         = module.data.projects.ami_app.golden_image_id
  shortname            = module.data.github_vars.general_tag_shortname
  app_repository_url   = module.data.github_vars.app_repository_url
  vpc                  = module.data.projects.vpc_app.vpc
  rds                  = module.data.projects.rds_app.rds
  efs                  = module.data.projects.efs_app.efs
  sg_elb_rules = {
    ingress = {
      HTTP = { port = 443, cidr_ipv4 = "0.0.0.0/0" }
    },
    egress = {
      All = { ip_protocol = "-1", cidr_ipv4 = "0.0.0.0/0" }
    }
  }
  sg_launch_tpl_rules = {
    ingress = {
      SSH  = { port = 22 }
      HTTP = { port = 80, cidr_ipv4 = "0.0.0.0/0" }
    },
    egress = {
      EFS   = { port = 2049 }
      MYSQL = { port = 3306 }
      SSH   = { port = 22, cidr_ipv4 = "0.0.0.0/0" }  # USER DATA
      HTTPS = { port = 443, cidr_ipv4 = "0.0.0.0/0" } # USER DATA
      HTTP = { port = 80, cidr_ipv4 = "0.0.0.0/0" } # USER DATA
    }
  }
}
