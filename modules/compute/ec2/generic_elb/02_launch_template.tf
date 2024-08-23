
locals {
  user_data = templatefile(
    "${path.module}/scripts/userdata.tftpl", {
      EFS_DNS_NAME       = var.efs.dns_name,
      APP_REPOSITORY_URL = var.app_repository_url,
      DOMAIN             = var.domain,
      DB_HOST            = var.rds.private_ip,
      DB_NAME            = var.rds.db_name,
      DB_USERNAME        = var.rds.db_username,
      DB_PASSWORD        = nonsensitive(data.aws_ssm_parameter.db_password.value),
      MEU_TESTE = templatefile(
        "${path.module}/scripts/teste.tftpl", {
          DOMAIN = "maooooes.com"
        }
      )
    }
  )
}
resource "null_resource" "debug_user_data" {
  provisioner "local-exec" {
    command = "echo '${base64encode(local.user_data)}' | base64 --decode"
  }
}

resource "aws_launch_template" "this" {
  depends_on = [ null_resource.debug_user_data ]
  name                   = "launch_tpl_${var.shortname}"
  update_default_version = true

  image_id      = var.ami_image_id
  instance_type = var.instance_type
  key_name      = var.ec2_ssh_keypair_name

  user_data = local.user_data

  # user_data = templatefile(
  #   "${path.module}/scripts/userdata.tftpl", {
  #     EFS_DNS_NAME       = var.efs.dns_name,
  #     APP_REPOSITORY_URL = var.app_repository_url,
  #     DOMAIN             = var.domain,
  #     DB_HOST            = var.rds.private_ip,
  #     DB_NAME            = var.rds.db_name,
  #     DB_USERNAME        = var.rds.db_username,
  #     DB_PASSWORD        = data.aws_ssm_parameter.db_password.value,
  #     MEU_TESTE = templatefile(
  #       "${path.module}/scripts/teste.tftpl", {
  #         DOMAIN = "maooooes.com"
  #       }
  #     )
  #   }
  # )

  vpc_security_group_ids = [
    module.sg_launch_tpl.security_group.id
  ]

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

  instance_initiated_shutdown_behavior = "terminate"

  monitoring {
    enabled = true
  }

  tags = {
    Name = "launch_tpl_${var.shortname}"
  }
}

