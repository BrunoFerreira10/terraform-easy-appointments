resource "aws_imagebuilder_image" "image-3" {
  distribution_configuration_arn   = aws_imagebuilder_distribution_configuration.distribution-1.arn
  image_recipe_arn                 = aws_imagebuilder_image_recipe.recipe-3.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.infrastructure-1.arn

  execution_role = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/imagebuilder.amazonaws.com/AWSServiceRoleForImageBuilder"
  workflow {
    workflow_arn = aws_imagebuilder_workflow.img-builder-workflow-1.arn
  }
}

# Excluindo snapshots associados à AMI
resource "aws_ami" "ami-from-imagebuilder-3" {
  count = length(aws_imagebuilder_image.image-3.output_resources[0].amis)

  name = element(aws_imagebuilder_image.image-3.output_resources[0].amis, count.index).image
  id   = element(aws_imagebuilder_image.image-3.output_resources[0].amis, count.index).image_id

  # Configuração de lifecycle para garantir que a AMI seja destruída
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_snapshot" "snapshot-from-ami-3" {
  count       = length(aws_ami.ami_from_imagebuilder-3[count.index].block_device_mappings)
  snapshot_id = aws_ami.ami_from_imagebuilder-3[count.index].block_device_mappings[count.index].snapshot_id

  # Configuração de lifecycle para garantir que o snapshot seja destruído
  lifecycle {
    prevent_destroy = false
  }
}

