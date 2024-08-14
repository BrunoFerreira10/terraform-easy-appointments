resource "aws_imagebuilder_image_recipe" "recipe-3" {
  name         = "${var.shortname}-recipe-3"
  version      = "1.0.0"
  parent_image = tolist(aws_imagebuilder_image.image-2.output_resources[0].amis)[0].image

  component {
    component_arn = aws_imagebuilder_component.download-github-project.arn
  }

  tags = {
    Name = name
  }
}