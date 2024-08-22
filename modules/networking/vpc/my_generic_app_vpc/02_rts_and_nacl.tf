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
  public_nacl_rules = [
    { rule_number = 100, egress = false, cidr = "0.0.0.0/0", port = 22 },
    { rule_number = 200, egress = false, cidr = "0.0.0.0/0", port = 80 },
    { rule_number = 300, egress = false, cidr = "0.0.0.0/0", port = 443 },
    { rule_number = 400, egress = false, cidr = "0.0.0.0/0", from_port = 32768, to_port = 65535 },
    { rule_number = 100, egress = true, cidr = "0.0.0.0/0", port = 22 },
    { rule_number = 200, egress = true, cidr = "0.0.0.0/0", port = 80 },
    { rule_number = 300, egress = true, cidr = "0.0.0.0/0", port = 443 },
    { rule_number = 400, egress = true, cidr = "0.0.0.0/0", port = 3306 },
    { rule_number = 500, egress = true, cidr = "0.0.0.0/0", from_port = 32768, to_port = 65535 }
  ]
  private_nacl_rules = [
    { rule_number = 100, egress = false, cidr = aws_vpc.app.cidr_block, port = 22 },
    { rule_number = 200, egress = false, cidr = "0.0.0.0/0", port = 80 },
    { rule_number = 300, egress = false, cidr = "0.0.0.0/0", port = 443 },
    { rule_number = 400, egress = false, cidr = "0.0.0.0/0", port = 3306 },
    { rule_number = 500, egress = false, cidr = "0.0.0.0/0", from_port = 32768, to_port = 65535 },
    { rule_number = 100, egress = true, cidr = "0.0.0.0/0", from_port = 1024, to_port = 65535 },
  ]
}

## --------------------------------------------------------------------------------------------------------------------
## Create a map with 'ids' from original list.
## --------------------------------------------------------------------------------------------------------------------
locals {
  public_nacl_rules_map = zipmap(
    range(length(local.public_nacl_rules)), local.public_nacl_rules
  )
  private_nacl_rules_map = zipmap(
    range(length(local.private_nacl_rules)), local.private_nacl_rules
  )
}

## --------------------------------------------------------------------------------------------------------------------
## Create NACL rules dynamically
## --------------------------------------------------------------------------------------------------------------------
resource "aws_network_acl_rule" "public" {
  for_each = local.public_nacl_rules_map

  network_acl_id = aws_network_acl.public.id
  rule_number    = each.value.rule_number
  egress         = each.value.egress
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = each.value.cidr
  from_port      = contains(keys(each.value), "port") ? each.value.port : each.value.from_port
  to_port        = contains(keys(each.value), "port") ? each.value.port : each.value.to_port
}

resource "aws_network_acl_rule" "private" {
  for_each = local.private_nacl_rules_map

  network_acl_id = aws_network_acl.private.id
  rule_number    = each.value.rule_number
  egress         = each.value.egress
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = each.value.cidr
  from_port      = contains(keys(each.value), "port") ? each.value.port : each.value.from_port
  to_port        = contains(keys(each.value), "port") ? each.value.port : each.value.to_port
}