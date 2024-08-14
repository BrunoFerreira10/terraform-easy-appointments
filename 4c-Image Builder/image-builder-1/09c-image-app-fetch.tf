resource "aws_imagebuilder_image" "image-3" {
  distribution_configuration_arn   = aws_imagebuilder_distribution_configuration.distribution-1.arn
  image_recipe_arn                 = aws_imagebuilder_image_recipe.recipe-3.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.infrastructure-1.arn

  execution_role = "arn:aws:iam::096320584768:role/aws-service-role/imagebuilder.amazonaws.com/AWSServiceRoleForImageBuilder"
  workflow {
    workflow_arn = aws_imagebuilder_workflow.img-builder-workflow-1.arn
  }
}

