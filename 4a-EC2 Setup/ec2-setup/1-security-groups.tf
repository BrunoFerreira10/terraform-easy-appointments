resource "aws_security_group" "sg-ec2-setup" {
  name        = "sg_${var.shortname}_ec2_setup"
  description = "Security group o EC2 de Setup. SSH por IP."
  vpc_id      = data.terraform_remote_state.remote-state-vpc.outputs.vpcs-vpc-1-id

  # ingress {
  #   description = "sg-by-pass"
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = "-1"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  ingress {
    description = "Allow SSH, by ip"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

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

  tags = {
    Name = "sg-${var.shortname}-ec2-setup"
  }
}