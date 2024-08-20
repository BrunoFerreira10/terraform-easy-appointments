resource "aws_security_group" "rds" {
  name        = "sg_rds_${var.shortname}"
  description = "Security group o RDS do projeto ${var.shortname}"
  vpc_id      = var.vpc.id

  ingress {
    description = "Allow MySQL"
    from_port   = 3306
    to_port     = 3306
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow All output traffic."
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg_rds_${var.shortname}"
  }
}