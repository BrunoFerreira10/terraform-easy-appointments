# Create a new GitLab Lightsail Instance
resource "aws_lightsail_instance" "this" {
  name              = "ltsail_${var.shortname}"
  availability_zone = "${var.region}a"
  blueprint_id      = "lamp_8_bitnami"
  bundle_id         = "small_3_0"
  key_pair_name     = var.ec2_ssh_keypair_name

  user_data = templatefile("${path.module}/scripts/userdata.sh.tpl", {
    REGION                = var.region
    IAM_USER_ARN          = aws_iam_user.lightsail_instance.arn
    AWS_ACCESS_KEY_ID     = aws_iam_access_key.lightsail_instance.id
    AWS_SECRET_ACCESS_KEY = aws_iam_access_key.lightsail_instance.secret
    INSTANCE_NAME         = "ltsail_${var.shortname}"
    CODEDEPLOY_ONPREMISES_YML = templatefile("${path.module}/scripts/codedeploy.onpremises.yml.tpl", {
      REGION                = var.region
      DOMAIN                = var.domain
      AWS_ACCESS_KEY_ID     = aws_iam_access_key.lightsail_instance.id
      AWS_SECRET_ACCESS_KEY = aws_iam_access_key.lightsail_instance.secret
      IAM_USER_ARN          = aws_iam_user.lightsail_instance.arn
    })
    SETUP_CONFIG_PHP_SH = templatefile("${path.module}/scripts/setup_config_php.sh.tpl", {
      DOMAIN = var.domain
    })
    BNCERT_TOOL_EXP = templatefile("${path.module}/scripts/bncert_tool.exp.tpl", {
    })
  })

  tags = {
    Name = "ltsail_${var.shortname}"
  }
}

# resource "null_resource" "run_commands" {
#   provisioner "remote-exec" {
#     connection {
#       type        = "ssh"
#       host        = aws_lightsail_instance.this.public_ip_address
#       user        = "bitnami"
#     }

#     inline = [
#       "echo 'Executando comandos remotos na instância Lightsail'",
#       "sudo apt-get update -y",
#       "sudo apt-get install -y <some_package>",
#       "sudo systemctl restart apache2",
#     ]
#   }

#   depends_on = [aws_lightsail_instance.this]
# }
