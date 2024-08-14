resource "aws_imagebuilder_infrastructure_configuration" "infrastructure-1" {
  name                          = "${var.shortname}-infrastructure-1"
  instance_types                = ["t3a.xlarge"]
  terminate_instance_on_failure = true

  subnet_id = data.terraform_remote_state.remote-state-vpc.outputs.vpcs-subnet-vpc-1-public-1a-id

  key_pair              = var.EC2_SSH_KEYPAIR_NAME
  instance_profile_name = aws_iam_instance_profile.img-builder-ec2-instance-profile.name
  security_group_ids = [
    aws_security_group.sg-image-builder-1.id
  ]

  # logging {
  #   s3_logs {
  #     s3_bucket_name = data.terraform_remote_state.remote-s3-logging.outputs.s3-logging-s3-logging-1-bucket
  #     s3_key_prefix  = "img-builder-infrastructure"
  #   }
  # }
}