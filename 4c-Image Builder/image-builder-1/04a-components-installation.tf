resource "aws_imagebuilder_component" "apt-update" {
  name        = "${var.shortname}-apt-update"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Atualiza lista de pacotes do apt."

  data = templatefile("${path.module}/components/installation-apt-update.tpl", {
    shortname = var.shortname
  })
}

resource "aws_imagebuilder_component" "apt-upgrade" {
  name        = "${var.shortname}-apt-upgrade"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Atualiza pacotes do apt."

  data = templatefile("${path.module}/components/installation-apt-upgrade.tpl", {
    shortname = var.shortname
  })
}

resource "aws_imagebuilder_component" "enable-ssh-agent" {
  name        = "${var.shortname}-enable-ssh-agent"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Habilita o ssh-agent no boot da instância."

  data = templatefile("${path.module}/components/installation-enable-ssh-agent.tpl", {
    shortname = var.shortname
  })
}

resource "aws_imagebuilder_component" "install-aws-cli" {
  name        = "${var.shortname}-install-aws-cli"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Instala o AWS CLI."

  data = templatefile("${path.module}/components/installation-aws-cli.tpl", {
    shortname = var.shortname
  })
}

resource "aws_imagebuilder_component" "install-nginx" {
  name        = "${var.shortname}-install-nginx"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Instala o nginx."

  data = templatefile("${path.module}/components/installation-nginx.tpl", {
    shortname = var.shortname
  })
}

resource "aws_imagebuilder_component" "install-php" {
  name        = "${var.shortname}-install-php"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Instala o PHP com extensões comuns para aplicações web."

  data = templatefile("${path.module}/components/installation-php.tpl", {
    shortname = var.shortname
  })
}

