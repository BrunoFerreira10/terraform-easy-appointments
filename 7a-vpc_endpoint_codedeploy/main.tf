module "deploy_app" {
  source                   = "../modules/networking/vpc/generic_vpc_endpoint_interface"
  region = module.data.github_vars.general_region
  sg_vpc_endpoint_codedeploy_rules = {
    ingress = {
      All = {ip_protocol = "-1", cidr_ipv4 = "0.0.0.0/0"}
    },
    egress = {
      All = {ip_protocol = "-1", cidr_ipv4 = "0.0.0.0/0"}
    }
  }
  shortname = module.data.github_vars.general_tag_shortname
  vpc = module.data.projects.vpc_app.vpc
}