resource "aws_imagebuilder_component" "ssh-add" {
  name        = "${var.shortname}-ssh-add"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Adiciona chave privada do github ao ssh-agent."

  data = yamlencode({
    phases = [{
      name = "build"
      steps = [{
        action = "ExecuteBash"
        inputs = {
          commands = [
            # Configurar o ssh-agent para rodar em background
            "eval \"$(ssh-agent -s)\"",

            # Adicionar a chave SSH ao ssh-agent
            "ssh-add /home/ubuntu/.ssh/id_rsa"
          ]
        }
        name      = upper("${var.shortname}-ssh-add")
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
            "sudo -u ubuntu git remote add origin ${var.APP_REPOSITORY_URL}",
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

resource "aws_imagebuilder_component" "nginx-reload" {
  name        = "${var.shortname}-nginx-reload"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Adiciona chave privada do github ao ssh-agent."

  data = yamlencode({
    phases = [{
      name = "build"
      steps = [{
        action = "ExecuteBash"
        inputs = {
          commands = [
            "systemctl daemon-reload",
            "systemctl restart nginx"
          ]
        }
        name      = upper("${var.shortname}-nginx-reload")
        onFailure = "Abort"
      }]
    }]
    schemaVersion = 1.0
  })
}