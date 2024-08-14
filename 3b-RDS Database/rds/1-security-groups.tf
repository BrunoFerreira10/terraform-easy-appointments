resource "aws_security_group" "rds-1" {
  name        = "sg_${var.GENERAL_TAG_SHORTNAME}_rds_1"
  description = "Security group o RDS 1."
  vpc_id      = data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-id

  # ingress {
  #   description = "sg-by-pass"
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = "-1"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  ingress {
    description = "Allow MySQL"
    from_port   = 3306
    to_port     = 3306
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg_${var.GENERAL_TAG_SHORTNAME}_rds_1"
  }
}