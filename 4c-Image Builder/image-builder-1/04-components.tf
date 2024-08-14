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

resource "aws_imagebuilder_component" "apply-github-ssh-private-key" {
  name        = "${var.shortname}-apply-github-ssh-private-key"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Configura chave privada do GitHub para clonar repositórios."

  data = yamlencode({
    phases = [{
      name = "build"
      steps = [{
        action = "ExecuteBash"
        inputs = {
          commands = [
            # Recuperar a chave privada do SSM Parameter Store
            "PRIVATE_KEY=$(aws ssm get-parameter --name 'SSH_PRIVATE_KEY_GITHUB' --with-decryption --query 'Parameter.Value' --output text)",

            # Criar o diretório .ssh se não existir
            "mkdir -p /home/ubuntu/.ssh",

            # Adicionar a chave privada ao arquivo id_rsa
            "echo \"$PRIVATE_KEY\" > /home/ubuntu/.ssh/id_rsa",
            "chmod 600 /home/ubuntu/.ssh/id_rsa",

            # Configurar o ssh-agent para rodar em background
            "eval \"$(ssh-agent -s)\"",

            # Adicionar a chave SSH ao ssh-agent
            "ssh-add /home/ubuntu/.ssh/id_rsa",

            # Configurar permissões corretas
            "chown ubuntu:ubuntu /home/ubuntu/.ssh/id_rsa"
          ]
        }
        name      = upper("${var.shortname}-apply-github-ssh-private-key")
        onFailure = "Abort"
      }]
    }]
    schemaVersion = 1.0
  })
}

resource "aws_imagebuilder_component" "download-github-project" {
  name        = "${var.shortname}-download-github-project"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Download da aplicação '${var.shortname}' hospedada no Github."

  data = yamlencode({
    phases = [{
      name = "build"
      steps = [{
        action = "ExecuteBash"
        inputs = {
          commands = [
            "cd /var/www/html",
            "rm -rf ./*",
            "chown -R ubuntu:ubuntu ./",
            "sudo -u ubuntu git config --global --add safe.directory /var/www/html",
            "sudo -u ubuntu git init",
            "sudo -u ubuntu git remote add origin git@github.com:BrunoFerreira10/layered-arch-app.git",
            "sudo -u ubuntu GIT_SSH_COMMAND='ssh -o StrictHostKeyChecking=no' git fetch origin",
            "sudo -u ubuntu git reset --hard origin/master"
            # "sudo -u ubuntu git clone git@github.com:BrunoFerreira10/layered-arch-app.git /var/www/html"
          ]
        }
        name      = upper("${var.shortname}-download-github-project")
        onFailure = "Abort"
      }]
    }]
    schemaVersion = 1.0
  })
}