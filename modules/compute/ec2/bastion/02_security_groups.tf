module "sg_bastion" {
  source = "../../../networking/vpc/generic_security_group"
  shortname = var.shortname
  vpc       = var.vpc
  security_group_settings = {
    id_name = "bastion"
    description = "Security group for bastion host"
    rules = {
      ingress = {
        SSH = {port = 22, cidr_block = "0.0.0.0/0"}
      },
      egress = {
        SSH = {port = 22},
        HTTP = {port = 80, cidr_block = "0.0.0.0/0"},
        HTTPS = {port = 443, cidr_block = "0.0.0.0/0"}
      }
    }
  }
}