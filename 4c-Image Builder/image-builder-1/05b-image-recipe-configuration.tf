resource "aws_imagebuilder_image_recipe" "recipe-2" {
  name         = "${var.shortname}-recipe-2"
  version      = "1.0.0"
  parent_image = tolist(aws_imagebuilder_image.image-1.output_resources[0].amis)[0].image

  component {
    component_arn = aws_imagebuilder_component.apply-github-ssh-private-key.arn
  }
}