## --------------------------------------------------------------------------------------------------------------------
## Recipe for AMI installation. 
## --------------------------------------------------------------------------------------------------------------------
## Recipe components
locals {
  component_arns_installation = [
    "arn:aws:imagebuilder:${var.region}:aws:component/amazon-cloudwatch-agent-linux/1.0.1/1",
    aws_imagebuilder_component.this["apt_update"].arn,
    aws_imagebuilder_component.this["apt_upgrade"].arn,
    aws_imagebuilder_component.this["efs_utils_install"].arn,
    aws_imagebuilder_component.this["aws_cli_install"].arn,
    aws_imagebuilder_component.this["nginx_install"].arn,
    aws_imagebuilder_component.this["php_install"].arn,
    aws_imagebuilder_component.this["composer_install"].arn,
    aws_imagebuilder_component.this["node_install"].arn
  ]
}

## Recipe
resource "aws_imagebuilder_image_recipe" "installation" {
  name         = "recipe_installation_${var.shortname}"
  version      = "1.0.0"
  parent_image = var.installation_parent_image

  dynamic "component" {
    for_each = local.component_arns_installation
    content {
      component_arn = component.value
    }
  }

  tags = {
    Name = "recipe_installation_${var.shortname}"
  }
}

## --------------------------------------------------------------------------------------------------------------------
## Recipe for AMI application.
## --------------------------------------------------------------------------------------------------------------------
## Recipe components
locals {
  component_arns_app_setup = [
    # aws_imagebuilder_component.this["git_fetch_repository"].arn,
    # aws_imagebuilder_component.this["easy_appointments_setup"].arn,
    aws_imagebuilder_component.this["daemon_reload"].arn,
    aws_imagebuilder_component.this["nginx_restart"].arn
  ]
}

## Recipe
resource "aws_imagebuilder_image_recipe" "application" {
  name         = "recipe_application_${var.shortname}"
  version      = "1.0.0"
  parent_image = tolist(aws_imagebuilder_image.installation.output_resources[0].amis)[0].image

  dynamic "component" {
    for_each = local.component_arns_app_setup
    content {
      component_arn = component.value
    }
  }

  tags = {
    Name = "recipe_application_${var.shortname}"
  }
}
## --------------------------------------------------------------------------------------------------------------------