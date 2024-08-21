## --------------------------------------------------------------------------------------------------------------------
## Security group for ELB. Dynamic created.
## --------------------------------------------------------------------------------------------------------------------
locals {
  sg_elb_setup = {
    ingress = {
      HTTP = {
        port = 80, cidr_blocks = ["0.0.0.0/0"]
      },
      HTTPS = {
        port = 443, cidr_blocks = ["0.0.0.0/0"]
      }
    },
    egress = {
      All = {
        port = 0, cidr_blocks = ["0.0.0.0/0"],
        description = "Allow all traffic"
      }
    }
  }
}

resource "aws_security_group" "elb" {
  name        = "sg_elb_${var.shortname}"
  description = "Security group para o ELB"
  vpc_id      = var.vpc.id

  tags = {
    Name = "sg_elb_${var.shortname}"
  }
}

resource "aws_vpc_security_group_ingress_rule" "elb" {
  for_each = local.sg_elb_setup.ingress

  description       = lookup(each.value,"description","Allow ${each.key}")
  security_group_id = aws_security_group.elb.id
  cidr_ipv4         = lookup(each.value,"cidr_blocks",[var.vpc.cidr_block])
  ip_protocol       = lookup(each.value,"protocol","tcp")
  from_port         = lookup(each.value,"from_port",each.value.port)
  to_port           = lookup(each.value,"to_port",each.value.port)
}

resource "aws_vpc_security_group_egress_rule" "elb" {
  for_each = local.sg_elb_setup.egress

  description       = lookup(each.value,"description","Allow ${each.key}")
  security_group_id = aws_security_group.elb.id
  cidr_ipv4         = lookup(each.value,"cidr_blocks",[var.vpc.cidr_block])
  ip_protocol       = lookup(each.value,"protocol","tcp")
  from_port         = lookup(each.value,"from_port",each.value.port)
  to_port           = lookup(each.value,"to_port",each.value.port)
}

## --------------------------------------------------------------------------------------------------------------------
## Security group for Instance on Target Group. Dynamic created.
## --------------------------------------------------------------------------------------------------------------------
locals {
  sg_launch_tpl_setup = {
    ingress = {
      HTTP = {
        port = 80, cidr_blocks = ["0.0.0.0/0"]
      },
      HTTPS = {
        port = 443, cidr_blocks = ["0.0.0.0/0"]
      }
    },
    egress = {
      All = {
        port = 0, cidr_blocks = ["0.0.0.0/0"],
        description = "Allow all traffic"
      }
    }
  }
}

resource "aws_security_group" "launch_tpl" {
  name        = "sg_launch_tpl_${var.shortname}"
  description = "Security group para o ELB"
  vpc_id      = var.vpc.id

  tags = {
    Name = "sg_launch_tpl_${var.shortname}"
  }
}

resource "aws_vpc_security_group_ingress_rule" "launch_tpl" {
  for_each = local.sg_launch_tpl_setup.ingress

  description       = lookup(each.value,"description","Allow ${each.key}")
  security_group_id = aws_security_group.launch_tpl.id
  cidr_ipv4         = lookup(each.value,"cidr_blocks",[var.vpc.cidr_block])
  ip_protocol       = lookup(each.value,"protocol","tcp")
  from_port         = lookup(each.value,"from_port",each.value.port)
  to_port           = lookup(each.value,"to_port",each.value.port)
}

resource "aws_vpc_security_group_egress_rule" "launch_tpl" {
  for_each = local.sg_launch_tpl_setup.egress

  description       = lookup(each.value,"description","Allow ${each.key}")
  security_group_id = aws_security_group.launch_tpl.id
  cidr_ipv4         = lookup(each.value,"cidr_blocks",[var.vpc.cidr_block])
  ip_protocol       = lookup(each.value,"protocol","tcp")
  from_port         = lookup(each.value,"from_port",each.value.port)
  to_port           = lookup(each.value,"to_port",each.value.port)
}
## --------------------------------------------------------------------------------------------------------------------