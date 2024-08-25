## TODO - Pipeline apenas de exemplo.
resource "aws_imagebuilder_image_pipeline" "this" {
  name = "${var.shortname}"

  image_recipe_arn                 = aws_imagebuilder_image_recipe.application.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.this.arn
  distribution_configuration_arn   = aws_imagebuilder_distribution_configuration.application.arn

  ## TODO - Criar Role local no IAM
  execution_role = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/imagebuilder.amazonaws.com/AWSServiceRoleForImageBuilder"
  workflow {
    workflow_arn = aws_imagebuilder_workflow.build.arn
  }

  tags = {
    Name = "${var.shortname}"
  }
}