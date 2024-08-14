resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.vpc-1.id

  tags = {
    Name = "sg-${var.shortname}-vpc-1-default"
  }
}