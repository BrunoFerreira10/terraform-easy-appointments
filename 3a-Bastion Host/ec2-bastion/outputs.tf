output "bastion-vpc-1-id" {
  value = aws_instance.bastion-vpc-1.id
}

output "bastion-vpc-1-public-ip" {
  value = aws_instance.bastion-vpc-1.public_ip
}