resource "aws_instance" "bastion-vpc-1" {
  # Ubuntu Server 24.04 LTS (HVM), SSD Volume Type
  ami = "ami-04b70fa74e45c3917"

  instance_type        = "t3.micro"
  key_name             = var.EC2_SSH_KEYPAIR_NAME
  subnet_id            = data.terraform_remote_state.remote-state-vpc.outputs.vpcs-subnet-vpc-1-public-1a-id
  iam_instance_profile = aws_iam_instance_profile.ec2-instance-profile-bastion-host.name

  vpc_security_group_ids = [
    aws_security_group.sg-bastion-host.id
  ]
  associate_public_ip_address = true

  user_data_replace_on_change = true
  user_data = templatefile(
    "${path.module}/ec2-userdata.tftpl", {
      REGION = "${var.region}"
    }
  )

  tags = {
    Name = "${var.shortname}-bastion-vpc-1"
  }
}