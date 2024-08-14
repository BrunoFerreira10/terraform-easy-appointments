output "ec2-setup-id" {
  value = aws_instance.ec2-setup.id
}

output "ec2-setup-public-ip" {
  value = aws_instance.ec2-setup.public_ip
}