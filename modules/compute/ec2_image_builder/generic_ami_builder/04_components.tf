resource "aws_imagebuilder_component" "apt_update" {
  name        = "${var.shortname}_apt_update"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Atualiza lista de pacotes do apt."

  data = templatefile("${path.module}/components/apt_update.tpl", {
    name = upper("${var.shortname}_apt_update")
  })
}

resource "aws_imagebuilder_component" "apt_upgrade" {
  name        = "${var.shortname}_apt_upgrade"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Atualiza pacotes do apt."

  data = templatefile("${path.module}/components/apt_upgrade.tpl", {
    name = upper("${var.shortname}_apt_upgrade")
  })
}

resource "aws_imagebuilder_component" "aws_cli_install" {
  name        = "${var.shortname}_aws_cli_install"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Instala o AWS CLI."

  data = templatefile("${path.module}/components/aws_cli_install.tpl", {
    name = upper("${var.shortname}_aws_cli_install")
  })
}

resource "aws_imagebuilder_component" "composer_install" {
  name        = "${var.shortname}_composer_install"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Instala o AWS CLI."

  data = templatefile("${path.module}/components/composer_install.tpl", {
    name = upper("${var.shortname}_composer_install")
  })
}

resource "aws_imagebuilder_component" "daemon_reload" {
  name        = "${var.shortname}_daemon_reload"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Recarrega configurações do gerenciador de serviços systemd."

  data = templatefile("${path.module}/components/daemon_reload.tpl", {
    name = upper("${var.shortname}_daemon_reload")
  })
}

resource "aws_imagebuilder_component" "easy_appointments_setup" {
  name        = "${var.shortname}_easy_appointments_setup"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Configuração da aplicação '${var.shortname}'."

  data = templatefile("${path.module}/components/easy_appointments_setup.tpl", {
    name               = upper("${var.shortname}_easy_appointments_setup"),
    app_repository_url = var.app_repository_url,
    BASE_URL           = var.domain,
    DB_HOST            = var.rds.db_host
    DB_NAME            = var.rds.db_name,
    DB_USERNAME        = var.rds.db_username,
    DB_PASSWORD        = data.aws_ssm_parameter.db_password.value
  })
}

resource "aws_imagebuilder_component" "git_fetch_repository" {
  name        = "${var.shortname}_git_fetch_repository"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Download da aplicação '${var.shortname}' hospedada no Github."

  data = templatefile("${path.module}/components/git_fetch_repository.tpl", {
    name               = upper("${var.shortname}_git_fetch_repository"),
    app_repository_url = var.app_repository_url
  })
}

resource "aws_imagebuilder_component" "nginx_install" {
  name        = "${var.shortname}_nginx_install"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Instala o nginx."

  data = templatefile("${path.module}/components/nginx_install.tpl", {
    name = upper("${var.shortname}_nginx_install")
  })
}

resource "aws_imagebuilder_component" "nginx_restart" {
  name        = "${var.shortname}_nginx_restart"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Reinicia o nginx."

  data = templatefile("${path.module}/components/nginx_restart.tpl", {
    name = upper("${var.shortname}_nginx_restart")
  })
}

resource "aws_imagebuilder_component" "node_install" {
  name        = "${var.shortname}_node_install"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Instala o AWS CLI."

  data = templatefile("${path.module}/components/node_install.tpl", {
    name = upper("${var.shortname}_node_install")
  })
}

resource "aws_imagebuilder_component" "php_install" {
  name        = "${var.shortname}_php_install"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Instala o PHP com extensões comuns para aplicações web."

  data = templatefile("${path.module}/components/php_install.tpl", {
    name = upper("${var.shortname}_php_install")
  })
}

resource "aws_imagebuilder_component" "ssh_add_github_key" {
  name        = "${var.shortname}_ssh_add_github_key"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Adiciona chave privada do github ao ssh_agent."

  data = templatefile("${path.module}/components/ssh_add_github_key.tpl", {
    name = upper("${var.shortname}_ssh_add_github_key")
  })
}

resource "aws_imagebuilder_component" "ssh_agent_enable" {
  name        = "${var.shortname}_ssh_agent_enable"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Habilita o ssh_agent no boot da instância."

  data = templatefile("${path.module}/components/ssh_agent_enable.tpl", {
    name = upper("${var.shortname}_ssh_agent_enable")
  })
}

resource "aws_imagebuilder_component" "ssh_agent_start" {
  name        = "${var.shortname}_ssh_agent_start"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Inicia o ssh_agent na instância."

  data = templatefile("${path.module}/components/ssh_agent_start.tpl", {
    name = upper("${var.shortname}_ssh_agent_start")
  })
}