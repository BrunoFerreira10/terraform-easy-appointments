# VPC 1 Information
output "vpc-1-name" {
  description = "Nome da VPC-1"
  value       = aws_vpc.vpc-1.tags["Name"]
}

output "vpc-1-id" {
  description = "ID da VPC-1"
  value       = aws_vpc.vpc-1.id
}

output "vpc-1-cidr-block" {
  description = "CIDR Block da VPC-1"
  value       = aws_vpc.vpc-1.cidr_block
}

output "subnet-vpc-1-public-1a-id" {
  description = "VPC-1: ID da subnet publica 1a"
  value       = aws_subnet.subnet-vpc-1-public-1a.id
}

output "subnet-vpc-1-public-1b-id" {
  description = "VPC-1: ID da subnet publica 1b"
  value       = aws_subnet.subnet-vpc-1-public-1b.id
}

output "subnet-vpc-1-public-1c-id" {
  description = "VPC-1: ID da subnet publica 1c"
  value       = aws_subnet.subnet-vpc-1-public-1c.id
}

output "subnet-vpc-1-private-1a-id" {
  description = "VPC-1: ID da subnet privada 1a"
  value       = aws_subnet.subnet-vpc-1-private-1a.id
}

output "subnet-vpc-1-private-1b-id" {
  description = "VPC-1: ID da subnet privada 1b"
  value       = aws_subnet.subnet-vpc-1-private-1b.id
}

output "subnet-vpc-1-private-1c-id" {
  description = "VPC-1: ID da subnet privada 1c"
  value       = aws_subnet.subnet-vpc-1-private-1c.id
}