## --------------------------------------------------------------------------------------------------------------------
## Router tables
## --------------------------------------------------------------------------------------------------------------------
resource "aws_default_route_table" "default" {
  default_route_table_id = aws_vpc.app.default_route_table_id

  tags = {
    Name = "rt_default_app_${var.shortname}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.app.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.app.id
  }

  tags = {
    Name = "rt_public_app_${var.shortname}"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.app.id

  tags = {
    Name = "rt_private_app_${var.shortname}"
  }
}

## --------------------------------------------------------------------------------------------------------------------
## Network ACLs
## --------------------------------------------------------------------------------------------------------------------
resource "aws_default_network_acl" "default" {
  default_network_acl_id = aws_vpc.app.default_network_acl_id

  tags = {
    Name = "nacl_default_app_${var.shortname}"
  }
}

resource "aws_network_acl" "public" {
  vpc_id = aws_vpc.app.id

  tags = {
    Name = "nacl_public_app_${var.shortname}"
  }
}

resource "aws_network_acl" "private" {
  vpc_id = aws_vpc.app.id

  tags = {
    Name = "nacl_private_app_${var.shortname}"
  }
}

## --------------------------------------------------------------------------------------------------------------------
## NACLs Rules 
## --------------------------------------------------------------------------------------------------------------------
locals {
  nacl_rules = {
    public = {
      ingress = {
        SSH       = { rule_number = 100, cidr = "0.0.0.0/0", port = 22 },
        HTTP      = { rule_number = 200, cidr = "0.0.0.0/0", port = 80 },
        HTTPS     = { rule_number = 300, cidr = "0.0.0.0/0", port = 443 },
        EPHEMERAL = { rule_number = 400, cidr = "0.0.0.0/0", from_port = 1024, to_port = 65535 }
      },
      egress = {
        SSH       = { rule_number = 100, cidr = "0.0.0.0/0", port = 22 },
        HTTP      = { rule_number = 200, cidr = "0.0.0.0/0", port = 80 },
        HTTPS     = { rule_number = 300, cidr = "0.0.0.0/0", port = 443 },
        MYSQL     = { rule_number = 400, cidr = "0.0.0.0/0", port = 3306 },
        EPHEMERAL = { rule_number = 500, cidr = "0.0.0.0/0", from_port = 32768, to_port = 65535 }
      }
    },
    private = {
      ingress = {
        SSH       = { rule_number = 100, cidr = aws_vpc.app.cidr_block, port = 22 },
        HTTP      = { rule_number = 200, cidr = "0.0.0.0/0", port = 80 },
        HTTPS     = { rule_number = 300, cidr = "0.0.0.0/0", port = 443 },
        MYSQL     = { rule_number = 400, cidr = "0.0.0.0/0", port = 3306 },
        EPHEMERAL = { rule_number = 500, cidr = "0.0.0.0/0", from_port = 32768, to_port = 65535 }
      },
      egress = {
        EPHEMERAL = { rule_number = 100, cidr = "0.0.0.0/0", from_port = 1024, to_port = 65535 }
      }
    }
  }
}

## --------------------------------------------------------------------------------------------------------------------
## Create NACL rules dynamically
## --------------------------------------------------------------------------------------------------------------------
resource "aws_network_acl_rule" "public_ingress" {
  for_each = local.nacl_rules.public.ingress

  network_acl_id = aws_network_acl.public.id
  rule_number    = each.value.rule_number
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = each.value.cidr
  from_port      = contains(keys(each.value), "port") ? each.value.port : each.value.from_port
  to_port        = contains(keys(each.value), "port") ? each.value.port : each.value.to_port
}

resource "aws_network_acl_rule" "public_egress" {
  for_each = local.nacl_rules.public.egress

  network_acl_id = aws_network_acl.public.id
  rule_number    = each.value.rule_number
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = each.value.cidr
  from_port      = contains(keys(each.value), "port") ? each.value.port : each.value.from_port
  to_port        = contains(keys(each.value), "port") ? each.value.port : each.value.to_port
}

resource "aws_network_acl_rule" "private_ingress" {
  for_each = local.nacl_rules.private.ingress

  network_acl_id = aws_network_acl.private.id
  rule_number    = each.value.rule_number
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = each.value.cidr
  from_port      = contains(keys(each.value), "port") ? each.value.port : each.value.from_port
  to_port        = contains(keys(each.value), "port") ? each.value.port : each.value.to_port
}

resource "aws_network_acl_rule" "private_egress" {
  for_each = local.nacl_rules.private.egress

  network_acl_id = aws_network_acl.private.id
  rule_number    = each.value.rule_number
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = each.value.cidr
  from_port      = contains(keys(each.value), "port") ? each.value.port : each.value.from_port
  to_port        = contains(keys(each.value), "port") ? each.value.port : each.value.to_port
}