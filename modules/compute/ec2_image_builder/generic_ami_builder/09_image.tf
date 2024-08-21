resource "aws_imagebuilder_image" "installation" {
  distribution_configuration_arn   = aws_imagebuilder_distribution_configuration.installation.arn
  image_recipe_arn                 = aws_imagebuilder_image_recipe.installation.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.this.arn

  ## TODO - Criar role local no IAM
  execution_role = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/imagebuilder.amazonaws.com/AWSServiceRoleForImageBuilder"
  workflow {
    workflow_arn = aws_imagebuilder_workflow.build.arn
  }
}

resource "aws_imagebuilder_image" "application" {
  distribution_configuration_arn   = aws_imagebuilder_distribution_configuration.application.arn
  image_recipe_arn                 = aws_imagebuilder_image_recipe.application.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.this.arn

  ## TODO - Criar role local no IAM
  execution_role = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/imagebuilder.amazonaws.com/AWSServiceRoleForImageBuilder"
  workflow {
    workflow_arn = aws_imagebuilder_workflow.build.arn
  }
}