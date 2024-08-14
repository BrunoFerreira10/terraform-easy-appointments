resource "aws_imagebuilder_image_recipe" "recipe-2" {
  name         = "${var.shortname}-recipe-2"
  version      = "1.0.0"
  parent_image = var.IMAGE_BUILDER_PARENT_IMAGE

  component {
    component_arn = aws_imagebuilder_component.apply-github-ssh-private-key.arn
  }
}