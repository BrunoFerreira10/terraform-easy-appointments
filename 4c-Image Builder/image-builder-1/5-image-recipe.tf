resource "aws_imagebuilder_image_recipe" "recipe-1" {
  name         = "${var.shortname}-recipe-1"
  version      = "1.0.0"
  parent_image = var.IMAGE_BUILDER_PARENT_IMAGE

  component {
    component_arn = "arn:aws:imagebuilder:${var.region}:aws:component/amazon-cloudwatch-agent-linux/1.0.1/1"
  }
  component {
    component_arn = aws_imagebuilder_component.apt-update.arn
  }
  component {
    component_arn = aws_imagebuilder_component.apt-upgrade.arn
  }
  component {
    component_arn = aws_imagebuilder_component.nginx-installation.arn
  }
  component {
    component_arn = aws_imagebuilder_component.install-aws-cli.arn
  }
  component {
    component_arn = aws_imagebuilder_component.apply-github-ssh-private-key.arn
  }
  component {
    component_arn = aws_imagebuilder_component.download-github-project.arn
  }
}