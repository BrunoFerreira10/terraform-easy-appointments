## --------------------------------------------------------------------------------------------------------------------
## Image builder EC2 security group and rules
## --------------------------------------------------------------------------------------------------------------------
resource "aws_security_group" "image_builder_ec2" {
  name        = "sg_image_builder_ec2_${var.shortname}"
  description = "Security for Image Builder EC2"
  vpc_id      = var.vpc.id

  tags = {
    Name = "sg_image_builder_ec2_${var.shortname}"
  }
}

## Ingress Rules
resource "aws_vpc_security_group_ingress_rule" "image_builder_ec2_allow_ssh_access_by_ip" {
  description       = "Allow SSH, on ip 0.0.0.0"  
  security_group_id = aws_security_group.image_builder_ec2.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 22
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "image_builder_ec2_allow_http" {
  description       = "Allow HTTP, any origin" 
  security_group_id = aws_security_group.image_builder_ec2.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 80
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "image_builder_ec2_allow_https" {
  description       = "Allow HTTPS, any origin" 
  security_group_id = aws_security_group.image_builder_ec2.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "tcp"
  from_port         = 443
  to_port           = 443
}

## Egress Rules
resource "aws_vpc_security_group_egress_rule" "image_builder_ec2_allow_all_traffic" {
  description       = "Allow any port, any target" 
  security_group_id = aws_security_group.image_builder_ec2.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
## --------------------------------------------------------------------------------------------------------------------