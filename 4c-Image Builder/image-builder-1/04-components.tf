resource "aws_imagebuilder_component" "apt-update" {
  name        = "${var.shortname}-apt-update"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Atualiza lista de pacotes do apt."

  data = templatefile("${path.module}/components/apt-update.tpl", {
    name = upper("${var.shortname}-apt-update")
  })
}

resource "aws_imagebuilder_component" "apt-upgrade" {
  name        = "${var.shortname}-apt-upgrade"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Atualiza pacotes do apt."

  data = templatefile("${path.module}/components/apt-upgrade.tpl", {
    name = upper("${var.shortname}-apt-upgrade")
  })
}

resource "aws_imagebuilder_component" "aws-cli-install" {
  name        = "${var.shortname}-aws-cli-install"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Instala o AWS CLI."

  data = templatefile("${path.module}/components/aws-cli-install.tpl", {
    name = upper("${var.shortname}-aws-cli-install")
  })
}

resource "aws_imagebuilder_component" "daemon-reload" {
  name        = "${var.shortname}-daemon-reload"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Recarrega configurações do gerenciador de serviços systemd."

  data = templatefile("${path.module}/components/daemon-reload.tpl", {
    name = upper("${var.shortname}-daemon-reload")
  })
}

resource "aws_imagebuilder_component" "easy-appointments-setup" {
  name        = "${var.shortname}-easy-appointments-setup"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Configuração da aplicação '${var.shortname}'."

  data = templatefile("${path.module}/components/easy-appointments-setup.tpl", {
    name               = upper("${var.shortname}-easy-appointments-setup"),
    APP_REPOSITORY_URL = var.APP_REPOSITORY_URL,
    BASE_URL           = var.RT53_DOMAIN,
    DB_HOST            = split(":", data.terraform_remote_state.remote-state-rds.outputs.rds-rds-1-endpoint)[0],
    DB_NAME            = var.RDS_1_DB_NAME,
    DB_USERNAME        = var.RDS_1_DB_USERNAME,
    DB_PASSWORD        = data.aws_ssm_parameter.RDS_1_DB_PASSWORD.value
  })
}

resource "aws_imagebuilder_component" "git-fetch-repository" {
  name        = "${var.shortname}-git-fetch-repository"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Download da aplicação '${var.shortname}' hospedada no Github."

  data = templatefile("${path.module}/components/git-fetch-repository.tpl", {
    name               = upper("${var.shortname}-git-fetch-repository"),
    APP_REPOSITORY_URL = var.APP_REPOSITORY_URL
  })
}

resource "aws_imagebuilder_component" "nginx-install" {
  name        = "${var.shortname}-nginx-install"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Instala o nginx."

  data = templatefile("${path.module}/components/nginx-install.tpl", {
    name = upper("${var.shortname}-nginx-install")
  })
}

resource "aws_imagebuilder_component" "nginx-restart" {
  name        = "${var.shortname}-nginx-restart"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Reinicia o nginx."

  data = templatefile("${path.module}/components/nginx-restart.tpl", {
    name = upper("${var.shortname}-nginx-restart")
  })
}

resource "aws_imagebuilder_component" "php-install" {
  name        = "${var.shortname}-php-install"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Instala o PHP com extensões comuns para aplicações web."

  data = templatefile("${path.module}/components/php-install.tpl", {
    name = upper("${var.shortname}-php-install")
  })
}

resource "aws_imagebuilder_component" "ssh-add-github-key" {
  name        = "${var.shortname}-ssh-add-github-key"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Adiciona chave privada do github ao ssh-agent."

  data = templatefile("${path.module}/components/ssh-add-github-key.tpl", {
    name = upper("${var.shortname}-ssh-add-github-key")
  })
}

resource "aws_imagebuilder_component" "ssh-agent-enable" {
  name        = "${var.shortname}-ssh-agent-enable"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Habilita o ssh-agent no boot da instância."

  data = templatefile("${path.module}/components/ssh-agent-enable.tpl", {
    name = upper("${var.shortname}-ssh-agent-enable")
  })
}

resource "aws_imagebuilder_component" "ssh-agent-start" {
  name        = "${var.shortname}-ssh-agent-start"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Inicia o ssh-agent na instância."

  data = templatefile("${path.module}/components/ssh-agent-start.tpl", {
    name = upper("${var.shortname}-ssh-agent-start")
  })
}