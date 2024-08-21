resource "aws_imagebuilder_infrastructure_configuration" "this" {
  name                          = "${var.shortname}"
  instance_types                = ["t3a.medium"]
  terminate_instance_on_failure = true

  subnet_id = vpc.subnets.public.az_a.id

  key_pair              = var.ec2_ssh_keypair_name
  instance_profile_name = aws_iam_instance_profile.img_builder_ec2.name
  security_group_ids = [
    aws_security_group.image_builder_ec2.id
  ]

  tags = {
    Name = name
  }
}