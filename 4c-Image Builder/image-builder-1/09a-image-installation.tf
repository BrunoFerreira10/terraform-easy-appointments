resource "aws_imagebuilder_image" "image-1" {
  distribution_configuration_arn   = aws_imagebuilder_distribution_configuration.distribution-1.arn
  image_recipe_arn                 = aws_imagebuilder_image_recipe.recipe-1.arn
  infrastructure_configuration_arn = aws_imagebuilder_infrastructure_configuration.infrastructure-1.arn

  execution_role = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/aws-service-role/imagebuilder.amazonaws.com/AWSServiceRoleForImageBuilder"
  workflow {
    workflow_arn = aws_imagebuilder_workflow.img-builder-workflow-1.arn
  }
}

# # Gerenciar a AMI criada pelo Image Builder
# resource "aws_ami" "ami-from-imagebuilder-1" {
#   count = length(aws_imagebuilder_image.image-1.output_resources[0].amis)

#   name = element(aws_imagebuilder_image.image-1.output_resources[0].amis, count.index).image

#   # Configuração de lifecycle para garantir que a AMI seja destruída
#   lifecycle {
#     prevent_destroy = false
#   }
# }

# # Excluindo snapshots associados à AMI
# resource "aws_ebs_snapshot" "snapshot-from-ami-1" {
#   count = length(aws_ami.ami-from-imagebuilder-1[0].block_device_mappings)

#   volume_id = element(aws_ami.ami-from-imagebuilder-1[0].block_device_mappings[*].ebs.snapshot_id, count.index)

#   tags = {
#     Name = "${var.shortname}-snapshot-from-ami-1"
#   }

#   # Configuração de lifecycle para garantir que o snapshot seja destruído
#   lifecycle {
#     prevent_destroy = false
#   }
# }