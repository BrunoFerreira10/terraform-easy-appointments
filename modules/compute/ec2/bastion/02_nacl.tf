
locals {
  nacl_rules = {
    public = {
      ingress = {
        SSH       = { rule_number = 1100, port = 22, cidr_block = "${data.aws_ssm_parameter.my_ip.value}/32"},
        # EPHEMERAL = { rule_number = 400, cidr_block = "0.0.0.0/0", from_port = 1024, to_port = 65535 }
      },
      egress = {
        SSH       = { rule_number = 1100, port = 22 },
        HTTP      = { rule_number = 1200, port = 80, cidr_block = "0.0.0.0/0"},
        HTTPS     = { rule_number = 1300, port = 443, cidr_block = "0.0.0.0/0" },
        # EPHEMERAL = { rule_number = 500, cidr_block = "0.0.0.0/0", from_port = 1024, to_port = 65535 }
      }
    },
    private = {
      ingress = {
        SSH       = { rule_number = 1100, port = 22, cidr_block = "${aws_instance.bastion.public_ip}/32" },
      },
      egress = {}
    }
  }
}



## --------------------------------------------------------------------------------------------------------------------
## Create NACL rules dynamically
## --------------------------------------------------------------------------------------------------------------------
resource "aws_network_acl_rule" "public_ingress" {
  for_each = local.nacl_rules.public.ingress

  network_acl_id = var.vpc.nacl.public.id
  rule_number    = each.value.rule_number
  egress         = false
  protocol       = lookup(each.value,"protocol","tcp")
  rule_action    = lookup(each.value,"rule_action","allow")
  cidr_block     = lookup(each.value,"cidr_block",var.vpc.cidr_block) 
  from_port      = lookup(each.value,"protocol","tcp") == "-1" ? null : lookup(each.value,"from_port",each.value.port)
  to_port        = lookup(each.value,"protocol","tcp") == "-1" ? null : lookup(each.value,"to_port",each.value.port)
}

resource "aws_network_acl_rule" "private_egress" {
  for_each = local.nacl_rules.private.egress

  network_acl_id = var.vpc.nacl.private.id
  rule_number    = each.value.rule_number
  egress         = true
  protocol       = lookup(each.value,"protocol","tcp")
  rule_action    = lookup(each.value,"rule_action","allow")
  cidr_block     = lookup(each.value,"cidr_block",var.vpc.cidr_block) 
  from_port      = lookup(each.value,"protocol","tcp") == "-1" ? null : lookup(each.value,"from_port",each.value.port)
  to_port        = lookup(each.value,"protocol","tcp") == "-1" ? null : lookup(each.value,"to_port",each.value.port)
}
