resource "aws_imagebuilder_component" "wait-ssh-agent" {
  name        = "${var.shortname}-wait-ssh-agent"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Verifica e aguarda que o ssh-agent foi iniciado."

  data = templatefile("${path.module}/components/app-setup-wait-ssh-agent.tpl", {
    name = upper("${var.shortname}-wait-ssh-agent")
  })
}


resource "aws_imagebuilder_component" "ssh-add-github-key" {
  name        = "${var.shortname}-ssh-add-github-key"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Adiciona chave privada do github ao ssh-agent."

  data = templatefile("${path.module}/components/app-setup-ssh-add-github-key.tpl", {
    name = upper("${var.shortname}-ssh-add-github-key")
  })
}

resource "aws_imagebuilder_component" "download-github-project" {
  name        = "${var.shortname}-download-github-project"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Download da aplicação '${var.shortname}' hospedada no Github."

  data = templatefile("${path.module}/components/app-setup-download-github-project.tpl", {
    name               = upper("${var.shortname}-download-github-project"),
    APP_REPOSITORY_URL = var.APP_REPOSITORY_URL
  })
}

resource "aws_imagebuilder_component" "app-setup" {
  name        = "${var.shortname}-app-setup"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Configuração da aplicação '${var.shortname}'."

  data = templatefile("${path.module}/components/app-setup-download-github-project.tpl", {
    name               = upper("${var.shortname}-app-setup"),
    APP_REPOSITORY_URL = var.APP_REPOSITORY_URL,
    BASE_URL           = var.RT53_DOMAIN,
    DB_HOST            = split(":", data.terraform_remote_state.remote-state-rds.outputs.rds-rds-1-endpoint)[0],
    DB_NAME            = var.RDS_1_DB_NAME,
    DB_USERNAME        = var.RDS_1_DB_USERNAME,
    DB_PASSWORD        = data.aws_ssm_parameter.RDS_1_DB_PASSWORD.value
  })
}

resource "aws_imagebuilder_component" "nginx-reload" {
  name        = "${var.shortname}-nginx-reload"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Adiciona chave privada do github ao ssh-agent."

  data = templatefile("${path.module}/components/app-setup-nginx-reload.tpl", {
    name = upper("${var.shortname}-install-nginx")
  })
}
