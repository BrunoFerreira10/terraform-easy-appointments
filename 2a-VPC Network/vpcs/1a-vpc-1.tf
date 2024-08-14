# VPC
resource "aws_vpc" "vpc-1" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "vpc-${var.shortname}-1"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw-vpc-1" {
  vpc_id = aws_vpc.vpc-1.id

  tags = {
    Name = "igw-vpc-${var.shortname}-1"
  }
}