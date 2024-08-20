# Launch template 1
resource "aws_launch_template" "ltplt-1" {

  name                   = "ltplt-${var.shortname}-1"
  update_default_version = true

  # AMI
  image_id = data.terraform_remote_state.remote-image-builder.outputs.image-builder-golden-ami-id

  # Instance type
  instance_type = "t3.micro"

  # Key pair (ec2 ssh login)  
  key_name = var.EC2_SSH_KEYPAIR_NAME

  # Network settings
  vpc_security_group_ids = [
    aws_security_group.sg-elb-1-tgrp-1.id
  ]

  # Resource tags
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "ltplt-${var.shortname}-1"
    }
  }

  tag_specifications {
    resource_type = "volume"

    tags = {
      Name = "ltplt-${var.shortname}-1-ebs"
    }
  }

  tag_specifications {
    resource_type = "network-interface"

    tags = {
      Name = "ltplt-${var.shortname}-1-eni"
    }
  }

  # Advanced details
  instance_initiated_shutdown_behavior = "terminate"

  monitoring {
    enabled = true
  }

  # ebs_optimized = true

  tags = {
    Name = "ltplt-${var.shortname}-1"
  }
}

