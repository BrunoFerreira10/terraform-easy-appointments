

# Public Subnet AZ a
resource "aws_subnet" "subnet-vpc-1-public-1a" {
  vpc_id                  = aws_vpc.vpc-1.id
  cidr_block              = "10.1.1.0/24"
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true


  tags = {
    Name = "subnet-vpc-${var.shortname}-1-public-a-1"
  }
}
resource "aws_route_table_association" "rta-vpc-1-public-subnet-1a" {
  subnet_id      = aws_subnet.subnet-vpc-1-public-1a.id
  route_table_id = aws_route_table.rt-vpc-1-public-subnets.id
}
resource "aws_network_acl_association" "nacl-association-vpc-1-subnet-public-1a" {
  network_acl_id = aws_network_acl.nacl-vpc-1-public-subnets.id
  subnet_id      = aws_subnet.subnet-vpc-1-public-1a.id
}

# Private Subnet AZ a
resource "aws_subnet" "subnet-vpc-1-private-1a" {
  vpc_id            = aws_vpc.vpc-1.id
  cidr_block        = "10.1.2.0/24"
  availability_zone = "${var.region}a"

  tags = {
    Name = "subnet-vpc-${var.shortname}-1-private-a-1"
  }
}
resource "aws_route_table_association" "rta-vpc-1-private-subnet-1a" {
  subnet_id      = aws_subnet.subnet-vpc-1-private-1a.id
  route_table_id = aws_route_table.rt-vpc-1-private-subnets.id
}
resource "aws_network_acl_association" "nacl-association-vpc-1-subnet-private-1a" {
  network_acl_id = aws_network_acl.nacl-vpc-1-private-subnets.id
  subnet_id      = aws_subnet.subnet-vpc-1-private-1a.id
}

# Public Subnet AZ b
resource "aws_subnet" "subnet-vpc-1-public-1b" {
  vpc_id                  = aws_vpc.vpc-1.id
  cidr_block              = "10.1.3.0/24"
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-vpc-${var.shortname}-1-public-b-1"
  }
}
resource "aws_route_table_association" "rta-vpc-1-public-subnet-1b" {
  subnet_id      = aws_subnet.subnet-vpc-1-public-1b.id
  route_table_id = aws_route_table.rt-vpc-1-public-subnets.id
}
resource "aws_network_acl_association" "nacl-association-vpc-1-subnet-public-1b" {
  network_acl_id = aws_network_acl.nacl-vpc-1-public-subnets.id
  subnet_id      = aws_subnet.subnet-vpc-1-public-1b.id
}

# Private Subnet AZ b
resource "aws_subnet" "subnet-vpc-1-private-1b" {
  vpc_id            = aws_vpc.vpc-1.id
  cidr_block        = "10.1.4.0/24"
  availability_zone = "${var.region}b"

  tags = {
    Name = "subnet-vpc-${var.shortname}-1-private-b-1"
  }
}
resource "aws_route_table_association" "rta-vpc-1-private-subnet-1b" {
  subnet_id      = aws_subnet.subnet-vpc-1-private-1b.id
  route_table_id = aws_route_table.rt-vpc-1-private-subnets.id
}
resource "aws_network_acl_association" "nacl-association-vpc-1-subnet-private-1b" {
  network_acl_id = aws_network_acl.nacl-vpc-1-private-subnets.id
  subnet_id      = aws_subnet.subnet-vpc-1-private-1b.id
}

# Public Subnet AZ c
resource "aws_subnet" "subnet-vpc-1-public-1c" {
  vpc_id                  = aws_vpc.vpc-1.id
  cidr_block              = "10.1.5.0/24"
  availability_zone       = "${var.region}c"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-vpc-${var.shortname}-1-public-c-1"
  }
}
resource "aws_route_table_association" "rta-vpc-1-public-subnet-1c" {
  subnet_id      = aws_subnet.subnet-vpc-1-public-1c.id
  route_table_id = aws_route_table.rt-vpc-1-public-subnets.id
}
resource "aws_network_acl_association" "nacl-association-vpc-1-subnet-public-1c" {
  network_acl_id = aws_network_acl.nacl-vpc-1-public-subnets.id
  subnet_id      = aws_subnet.subnet-vpc-1-public-1c.id
}

# Private Subnet AZ c
resource "aws_subnet" "subnet-vpc-1-private-1c" {
  vpc_id            = aws_vpc.vpc-1.id
  cidr_block        = "10.1.6.0/24"
  availability_zone = "${var.region}c"

  tags = {
    Name = "subnet-vpc-${var.shortname}-1-private-c-1"
  }
}
resource "aws_route_table_association" "rta-vpc-1-private-subnet-1c" {
  subnet_id      = aws_subnet.subnet-vpc-1-private-1c.id
  route_table_id = aws_route_table.rt-vpc-1-private-subnets.id
}
resource "aws_network_acl_association" "nacl-association-vpc-1-subnet-private-1c" {
  network_acl_id = aws_network_acl.nacl-vpc-1-private-subnets.id
  subnet_id      = aws_subnet.subnet-vpc-1-private-1c.id
}