resource "aws_vpc" "app" {
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

resource "aws_internet_gateway" "app" {
  vpc_id = aws_vpc.app.id

  tags = {
    Name = "igw_app_${var.shortname}"
  }
}