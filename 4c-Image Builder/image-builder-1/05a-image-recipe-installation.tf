resource "aws_imagebuilder_image_recipe" "recipe-1" {
  name         = "${var.shortname}-recipe-1"
  version      = "1.0.0"
  parent_image = var.IMAGE_BUILDER_PARENT_IMAGE

  dynamic "component" {
    for_each = local.component_arns
    content {
      component_arn = component.value
    }
  }
}
locals {
  component_arns = [
    "arn:aws:imagebuilder:${var.region}:aws:component/amazon-cloudwatch-agent-linux/1.0.1/1",
    aws_imagebuilder_component.apt-update.arn,
    aws_imagebuilder_component.apt-upgrade.arn,
    aws_imagebuilder_component.enable-ssh-agent.arn,
    aws_imagebuilder_component.install-aws-cli.arn,
    aws_imagebuilder_component.install-nginx.arn,
    aws_imagebuilder_component.install-php.arn
  ]
}