resource "aws_imagebuilder_image_recipe" "recipe-1" {
  name         = "${var.shortname}-recipe-1"
  version      = "1.0.0"
  parent_image = var.IMAGE_BUILDER_PARENT_IMAGE

  dynamic "component" {
    for_each = local.component_arns_installation
    content {
      component_arn = component.value
    }
  }
}
locals {
  component_arns_installation = [
    "arn:aws:imagebuilder:${var.region}:aws:component/amazon-cloudwatch-agent-linux/1.0.1/1",
    aws_imagebuilder_component.apt-update.arn,
    aws_imagebuilder_component.apt-upgrade.arn,
    aws_imagebuilder_component.ssh-agent-enable.arn,
    aws_imagebuilder_component.aws-cli-install.arn,
    aws_imagebuilder_component.nginx-install.arn,
    aws_imagebuilder_component.php-install.arn
  ]
}

# resource "aws_imagebuilder_image_recipe" "recipe-2" {
#   name         = "${var.shortname}-recipe-2"
#   version      = "1.0.0"
#   parent_image = tolist(aws_imagebuilder_image.image-1.output_resources[0].amis)[0].image

#   dynamic "component" {
#     for_each = local.component_arns_configuration
#     content {
#       component_arn = component.value
#     }
#   }
# }
# locals {
#   component_arns_configuration = [
#   ]
# }

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
    aws_imagebuilder_component.git-fetch-repository.arn,
    aws_imagebuilder_component.easy-appointments-setup.arn,
    aws_imagebuilder_component.daemon-reload.arn,
    aws_imagebuilder_component.nginx-restart.arn
  ]
}