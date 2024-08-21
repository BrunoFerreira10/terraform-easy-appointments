resource "aws_launch_template" "this" {

  name                   = "launch_tpl_${var.shortname}"
  update_default_version = true

  # AMI
  image_id = var.ami_image_id

  # Instance type
  instance_type = var.instance_type

  # Key pair (ec2 ssh login)
  key_name = var.ec2_ssh_keypair_name

  # Network settings
  vpc_security_group_ids = [
    aws_security_group.launch_tpl.id
  ]

  # Resource tags
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "launch_tpl_${var.shortname}"
    }
  }

  tag_specifications {
    resource_type = "volume"

    tags = {
      Name = "launch_tpl_${var.shortname}_ebs"
    }
  }

  tag_specifications {
    resource_type = "network-interface"

    tags = {
      Name = "launch_tpl_${var.shortname}_eni"
    }
  }

  # Advanced details
  instance_initiated_shutdown_behavior = "terminate"

  monitoring {
    enabled = true
  }

  # ebs_optimized = true

  tags = {
    Name = "launch_tpl_${var.shortname}"
  }
}

