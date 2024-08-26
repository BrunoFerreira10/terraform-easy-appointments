resource "aws_vpc" "this" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "vpc_app_${var.shortname}"
  }
}

## -----------------------------------------------------------------------------
## Default security group deny all trafic 
## -----------------------------------------------------------------------------
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.app.id

  tags = {
    Name = "sg_default_app_${var.shortname}"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "igw_app_${var.shortname}"
  }
}

resource "aws_eip" "nat_gateway" {
  
}

resource "aws_nat_gateway" "this" {
  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.this]

  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.private_az_a.id

  tags = {
    Name = "nat_${var.shortname}"
  }
}