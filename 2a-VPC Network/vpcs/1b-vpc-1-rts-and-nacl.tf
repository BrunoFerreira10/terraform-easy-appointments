# Router tables
resource "aws_default_route_table" "rt-vpc-1-default" {
  default_route_table_id = aws_vpc.vpc-1.default_route_table_id

  tags = {
    Name = "rt-vpc-${var.shortname}-1-default"
  }
}

resource "aws_route_table" "rt-vpc-1-public-subnets" {
  vpc_id = aws_vpc.vpc-1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-vpc-1.id
  }

  tags = {
    Name = "rt-vpc-${var.shortname}-1-public-subnets"
  }
}

resource "aws_route_table" "rt-vpc-1-private-subnets" {
  vpc_id = aws_vpc.vpc-1.id

  tags = {
    Name = "rt-vpc-${var.shortname}-1-private-subnets"
  }
}


# Network ACLs
resource "aws_default_network_acl" "default" {
  default_network_acl_id = aws_vpc.vpc-1.default_network_acl_id

  tags = {
    Name = "nacl-vpc-${var.shortname}-1-default"
  }
}

resource "aws_network_acl" "nacl-vpc-1-public-subnets" {
  vpc_id = aws_vpc.vpc-1.id

  # ByPass
  # ingress {
  #   rule_no    = 11111
  #   protocol   = "-1"
  #   from_port  = 0
  #   to_port    = 0
  #   action     = "allow"
  #   cidr_block = "0.0.0.0/0"
  # }


  ingress {
    rule_no    = 100
    protocol   = "tcp"
    from_port  = 22
    to_port    = 22
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  ingress {
    rule_no    = 200
    protocol   = "tcp"
    from_port  = 80
    to_port    = 80
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  ingress {
    rule_no    = 300
    protocol   = "tcp"
    from_port  = 443
    to_port    = 443
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  ingress {
    rule_no    = 10000
    protocol   = "tcp"
    from_port  = 1024
    to_port    = 65535
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  # ByPass
  # egress {
  #   rule_no    = 11111
  #   protocol   = "-1"
  #   from_port  = 0
  #   to_port    = 0
  #   action     = "allow"
  #   cidr_block = "0.0.0.0/0"
  # }

  egress {
    rule_no    = 100
    protocol   = "tcp"
    from_port  = 80
    to_port    = 80
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  egress {
    rule_no    = 200
    protocol   = "tcp"
    from_port  = 443
    to_port    = 443
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  egress {
    rule_no    = 10000
    protocol   = "tcp"
    from_port  = 1024
    to_port    = 65535
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name = "nacl-vpc-${var.shortname}-1-public-subnets"
  }
}

resource "aws_network_acl" "nacl-vpc-1-private-subnets" {
  vpc_id = aws_vpc.vpc-1.id

  # ByPass
  # ingress {
  #   rule_no    = 11111
  #   protocol   = "-1"
  #   from_port  = 0
  #   to_port    = 0
  #   action     = "allow"
  #   cidr_block = "0.0.0.0/0"
  # }

  ingress {
    rule_no    = 100
    protocol   = "tcp"
    from_port  = 80
    to_port    = 80
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  ingress {
    rule_no    = 200
    protocol   = "tcp"
    from_port  = 443
    to_port    = 443
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  ingress {
    rule_no    = 300
    protocol   = "tcp"
    from_port  = 3306
    to_port    = 3306
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  ingress {
    rule_no    = 10000
    protocol   = "tcp"
    from_port  = 1024
    to_port    = 65535
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  # ByPass
  # egress {
  #   rule_no    = 11111
  #   protocol   = "-1"
  #   from_port  = 0
  #   to_port    = 0
  #   action     = "allow"
  #   cidr_block = "0.0.0.0/0"
  # }

  egress {
    rule_no    = 10000
    protocol   = "tcp"
    from_port  = 1024
    to_port    = 65535
    action     = "allow"
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name = "nacl-vpc-${var.shortname}-1-private-subnets"
  }
}