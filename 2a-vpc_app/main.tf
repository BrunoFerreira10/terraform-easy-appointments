module "vpc_app" {
  source    = "../modules/networking/vpc/my_generic_app_vpc"
  shortname = module.data.github_vars.general_tag_shortname
  region    = module.data.github_vars.general_region
  vpc_settings = {
    nacl_rules = {
      public = {
        ingress = {
          SSH       = { rule_number = 100, cidr_block = "0.0.0.0/0", port = 22 },
          HTTP      = { rule_number = 200, cidr_block = "0.0.0.0/0", port = 80 },
          HTTPS     = { rule_number = 300, cidr_block = "0.0.0.0/0", port = 443 },
          EPHEMERAL = { rule_number = 400, cidr_block = "0.0.0.0/0", from_port = 1024, to_port = 65535 }
        },
        egress = {
          SSH       = { rule_number = 100, cidr_block = "0.0.0.0/0", port = 22 },
          HTTP      = { rule_number = 200, cidr_block = "0.0.0.0/0", port = 80 },
          HTTPS     = { rule_number = 300, cidr_block = "0.0.0.0/0", port = 443 },
          MYSQL     = { rule_number = 400, cidr_block = "0.0.0.0/0", port = 3306 },
          EPHEMERAL = { rule_number = 500, cidr_block = "0.0.0.0/0", from_port = 32768, to_port = 65535 }
        }
      },
      private = {
        ingress = {
          SSH       = { rule_number = 100, port = 22 },
          HTTP      = { rule_number = 200, cidr_block = "0.0.0.0/0", port = 80 },
          HTTPS     = { rule_number = 300, cidr_block = "0.0.0.0/0", port = 443 },
          MYSQL     = { rule_number = 400, cidr_block = "0.0.0.0/0", port = 3306 },
          EPHEMERAL = { rule_number = 500, cidr_block = "0.0.0.0/0", from_port = 32768, to_port = 65535 }
        },
        egress = {
          EPHEMERAL = { rule_number = 100, cidr_block = "0.0.0.0/0", from_port = 1024, to_port = 65535 }
        }
      }
    }
  }  
}
