resource "aws_imagebuilder_component" "apt-update" {
  name        = "${var.shortname}-apt-update"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Atualiza lista de pacotes do apt."

  data = templatefile("${path.module}/components/installation-apt-update.tpl", {
    name = upper("${var.shortname}-apt-update")
  })
}

resource "aws_imagebuilder_component" "apt-upgrade" {
  name        = "${var.shortname}-apt-upgrade"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Atualiza pacotes do apt."

  data = templatefile("${path.module}/components/installation-apt-upgrade.tpl", {
    name = upper("${var.shortname}-apt-upgrade")
  })
}

resource "aws_imagebuilder_component" "enable-ssh-agent" {
  name        = "${var.shortname}-enable-ssh-agent"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Habilita o ssh-agent no boot da instância."

  data = templatefile("${path.module}/components/installation-enable-ssh-agent.tpl", {
    name = upper("${var.shortname}-enable-ssh-agent")
  })
}

resource "aws_imagebuilder_component" "install-aws-cli" {
  name        = "${var.shortname}-install-aws-cli"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Instala o AWS CLI."

  data = templatefile("${path.module}/components/installation-aws-cli.tpl", {
    name = upper("${var.shortname}-install-aws-cli")
  })
}

resource "aws_imagebuilder_component" "install-nginx" {
  name        = "${var.shortname}-install-nginx"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Instala o nginx."

  data = templatefile("${path.module}/components/installation-nginx.tpl", {
    name = upper("${var.shortname}-install-nginx")
  })
}

resource "aws_imagebuilder_component" "install-php" {
  name        = "${var.shortname}-install-php"
  version     = "1.0.0"
  platform    = "Linux"
  description = "Instala o PHP com extensões comuns para aplicações web."

  data = templatefile("${path.module}/components/installation-php.tpl", {
    name = upper("${var.shortname}-install-php")
  })
}

