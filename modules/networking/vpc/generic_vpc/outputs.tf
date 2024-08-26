output "vpc" {
  description = "App VPC information"
  value = {
    name       = "vpc_app"
    id         = aws_vpc.app.id
    cidr_block = aws_vpc.app.cidr_block
    nacl = {
      public = aws_network_acl.public
      private = aws_network_acl.private
    }
    subnets = {
      public = {
        az_a = {
          id         = aws_subnet.public_az_a.id
          cidr_block = aws_subnet.public_az_a.cidr_block
          az         = aws_subnet.public_az_a.availability_zone
        }
        az_b = {
          id         = aws_subnet.public_az_b.id
          cidr_block = aws_subnet.public_az_b.cidr_block
          az         = aws_subnet.public_az_b.availability_zone
        }
        az_c = {
          id         = aws_subnet.public_az_c.id
          cidr_block = aws_subnet.public_az_c.cidr_block
          az         = aws_subnet.public_az_c.availability_zone
        }
      }
      private = {
        az_a = {
          id         = aws_subnet.private_az_a.id
          cidr_block = aws_subnet.private_az_a.cidr_block
          az         = aws_subnet.private_az_a.availability_zone
        }
        az_b = {
          id         = aws_subnet.private_az_b.id
          cidr_block = aws_subnet.private_az_b.cidr_block
          az         = aws_subnet.private_az_b.availability_zone
        }
        az_c = {
          id         = aws_subnet.private_az_c.id
          cidr_block = aws_subnet.private_az_c.cidr_block
          az         = aws_subnet.private_az_c.availability_zone
        }
      }
    }
  }
}
