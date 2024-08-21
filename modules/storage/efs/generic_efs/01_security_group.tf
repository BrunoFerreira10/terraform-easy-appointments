## --------------------------------------------------------------------------------------------------------------------
## EFS mount targets security group and rules
## --------------------------------------------------------------------------------------------------------------------
resource "aws_security_group" "efs_mountpoints" {
  name        = "sg_efs_mountpoints_${var.shortname}"
  description = "Security group para os EFS mount points"
  vpc_id      = var.vpc.id

  tags = {
    Name = "sg_efs_mountpoints_${var.shortname}"
  }
}

## Igress Rules
resource "aws_vpc_security_group_ingress_rule" "allow_efs_access" {
  security_group_id = aws_security_group.efs_mountpoints.id
  cidr_ipv4         = aws_vpc.vpc.cidr_blocks // Same VPC only
  ip_protocol       = "tcp"
  from_port         = 2049
  to_port           = 2049
}

## Egress Rules
resource "aws_vpc_security_group_egress_rule" "allow_output_traffic" {
  security_group_id = aws_security_group.efs_mountpoints.id
  cidr_ipv4         = aws_vpc.vpc.cidr_blocks // Same VPC only
  ip_protocol       = "-1"
}
## --------------------------------------------------------------------------------------------------------------------