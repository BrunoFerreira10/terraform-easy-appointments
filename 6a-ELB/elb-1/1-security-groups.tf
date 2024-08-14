resource "aws_security_group" "sg-elb-1" {
  name        = "sg_${var.shortname}_elb_1"
  description = "Security group para o ELB 1"
  vpc_id      = data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-id

  # ingress {
  #   description = "sg-by-pass"
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = "-1"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-${var.shortname}-elb-1"
  }
}

resource "aws_security_group" "sg-elb-1-tgrp-1" {

  lifecycle {
    ignore_changes = [description]
  }

  name        = "sg_${var.shortname}_elb_1_tgrp_1"
  description = "Security group para instancias EC2 do Target Group 1 no ELB1"
  vpc_id      = data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-id

  # ingress {
  #   description = "sg-by-pass"
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = "-1"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-${var.shortname}-elb-1-tgrp-1"
  }
}