resource "aws_imagebuilder_component" "apt-update" {
  name        = "${var.shortname}-apt-update"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Atualiza lista de pacotes do apt."

  data = yamlencode({
    phases = [{
      name = "build"
      steps = [{
        action = "ExecuteBash"
        inputs = {
          commands = [
            "apt update"
          ]
        }
        name      = upper("${var.shortname}-apt-update")
        onFailure = "Abort"
      }]
    }]
    schemaVersion = 1.0
  })
}

resource "aws_imagebuilder_component" "apt-upgrade" {
  name        = "${var.shortname}-apt-upgrade"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Atualiza pacotes do apt."

  data = yamlencode({
    phases = [{
      name = "build"
      steps = [{
        action = "ExecuteBash"
        inputs = {
          commands = [
            "apt upgrade -y"
          ]
        }
        name      = upper("${var.shortname}-apt-upgrade")
        onFailure = "Abort"
      }]
    }]
    schemaVersion = 1.0
  })
}

resource "aws_imagebuilder_component" "install-aws-cli" {
  name        = "${var.shortname}-install-aws-cli"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Instala o AWS CLI."

  data = yamlencode({
    phases = [{
      name = "build"
      steps = [{
        action = "ExecuteBash"
        inputs = {
          commands = [
            "apt-get install -y unzip curl",
            "curl 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip' -o 'awscliv2.zip'",
            "unzip awscliv2.zip",
            "sudo ./aws/install"
          ]
        }
        name      = upper("${var.shortname}-install-aws-cli")
        onFailure = "Abort"
      }]
    }]
    schemaVersion = 1.0
  })
}

resource "aws_imagebuilder_component" "nginx-installation" {
  name        = "${var.shortname}-nginx-installation"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Instala o nginx."

  data = yamlencode({
    phases = [{
      name = "build"
      steps = [{
        action = "ExecuteBash"
        inputs = {
          commands = [
            "apt-get install -y nginx",
            "systemctl restart nginx",
          ]
        }
        name      = upper("${var.shortname}-nginx-installation")
        onFailure = "Abort"
      }]
    }]
    schemaVersion = 1.0
  })
}

resource "aws_imagebuilder_component" "php-installation" {
  name        = "${var.shortname}-php-installation"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Instala o PHP com extensões comuns para aplicações web."

  data = templatefile("${path.module}/components/installation-php.tpl", {
    shortname = var.shortname
  })
}
