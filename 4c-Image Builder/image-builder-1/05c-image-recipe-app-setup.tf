resource "aws_imagebuilder_image_recipe" "recipe-3" {
  name         = "${var.shortname}-recipe-3"
  version      = "1.0.0"
  parent_image = tolist(aws_imagebuilder_image.image-1.output_resources[0].amis)[0].image

  dynamic "component" {
    for_each = local.component_arns_app_setup
    content {
      component_arn = component.value
    }
  }
}
locals {
  component_arns_app_setup = [
    # aws_imagebuilder_component.wait-ssh-agent.arn,
    aws_imagebuilder_component.ssh-add-github-key.arn,
    aws_imagebuilder_component.download-github-project.arn,
    aws_imagebuilder_component.app-setup.arn,
    aws_imagebuilder_component.nginx-reload.arn
  ]
}