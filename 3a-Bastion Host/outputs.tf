output "ec2-bastion-bastion-vpc-1-id" {
  description = "VPC-1: Bastion Host, ID"
  value       = module.ec2-bastion.bastion-vpc-1-id
}

output "ec2-bastion-bastion-vpc-1-public_ip" {
  description = "VPC-1: Bastion Host, Public IP"
  value       = module.ec2-bastion.bastion-vpc-1-public-ip
}