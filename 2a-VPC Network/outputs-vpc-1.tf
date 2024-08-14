# VPC 1 Information
output "vpcs-vpc-1-name" {
  description = "Nome da VPC-1"
  value       = module.vpcs.vpc-1-name
}

output "vpcs-vpc-1-id" {
  description = "ID da VPC-1"
  value       = module.vpcs.vpc-1-id
}

output "vpcs-subnet-vpc-1-public-1a-id" {
  description = "VPC-1: ID da subnet publica 1a"
  value       = module.vpcs.subnet-vpc-1-public-1a-id
}

output "vpcs-subnet-vpc-1-public-1b-id" {
  description = "VPC-1: ID da subnet publica 1b"
  value       = module.vpcs.subnet-vpc-1-public-1b-id
}

output "vpcs-subnet-vpc-1-public-1c-id" {
  description = "VPC-1: ID da subnet publica 1c"
  value       = module.vpcs.subnet-vpc-1-public-1c-id
}

output "vpcs-subnet-vpc-1-private-1a-id" {
  description = "VPC-1: ID da subnet privada 1a"
  value       = module.vpcs.subnet-vpc-1-private-1a-id
}

output "vpcs-subnet-vpc-1-private-1b-id" {
  description = "VPC-1: ID da subnet privada 1b"
  value       = module.vpcs.subnet-vpc-1-private-1b-id
}

output "vpcs-subnet-vpc-1-private-1c-id" {
  description = "VPC-1: ID da subnet privada 1c"
  value       = module.vpcs.subnet-vpc-1-private-1c-id
}