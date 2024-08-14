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