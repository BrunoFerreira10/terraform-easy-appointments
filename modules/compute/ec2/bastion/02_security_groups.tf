module "sg_bastion" {
  source = "../../../networking/vpc/generic_security_group"
  shortname = var.shortname
  vpc       = var.vpc
  security_group_settings = {
    id_name = "bastion"
    description = "Security group for bastion host"
    rules = {
      ingress = {
        SSH = {port = 22, cidr_block = "0.0.0.0/0"}
      },
      egress = {
        SSH = {port = 22},
        HTTP = {port = 80, cidr_block = "0.0.0.0/0"},
        HTTPS = {port = 443, cidr_block = "0.0.0.0/0"}
      }
    }
  }
}


# resource "aws_security_group" "bastion" {
#   name        = "sg_bastion_${var.vpc.name}"
#   description = "Security group for Bastion Host EC2 on ${var.vpc.name}"
#   vpc_id      = var.vpc.id

#   ingress {
#     description = "Allow SSH, by ip"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "TCP"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     description = "Allow HTTP"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "TCP"
#     cidr_blocks = [var.vpc.cidr_block]
#   }

#   egress {
#     description = "Allow HTTP"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "TCP"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     description = "Allow HTTPS"
#     from_port   = 443
#     to_port     = 443
#     protocol    = "TCP"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   # egress {
#   #   from_port   = 0
#   #   to_port     = 0
#   #   protocol    = "-1"
#   #   cidr_blocks = ["0.0.0.0/0"]
#   # }

#   tags = {
#     Name = "sg_bastion_${var.vpc.name}"
#   }
# }