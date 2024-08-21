## --------------------------------------------------------------------------------------------------------------------
## Recipe for AMI installation. 
## --------------------------------------------------------------------------------------------------------------------
## Recipe components
locals {
  component_arns_installation = [
    "arn:aws:imagebuilder:${var.region}:aws:component/amazon-cloudwatch-agent-linux/1.0.1/1",
    aws_imagebuilder_component.apt_update.arn,
    aws_imagebuilder_component.apt_upgrade.arn,
    aws_imagebuilder_component.ssh_agent_enable.arn,
    aws_imagebuilder_component.aws_cli_install.arn,
    aws_imagebuilder_component.nginx_install.arn,
    aws_imagebuilder_component.php_install.arn,
    aws_imagebuilder_component.composer_install.arn,
    aws_imagebuilder_component.node_install.arn
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
    Name = name
  }
}

## --------------------------------------------------------------------------------------------------------------------
## Recipe for AMI application.
## --------------------------------------------------------------------------------------------------------------------
## Recipe components
locals {
  component_arns_app_setup = [
    aws_imagebuilder_component.git_fetch_repository.arn,
    aws_imagebuilder_component.easy_appointments_setup.arn,
    aws_imagebuilder_component.daemon_reload.arn,
    aws_imagebuilder_component.nginx_restart.arn
  ]
}

## Recipe
resource "aws_imagebuilder_image_recipe" "application" {
  name         = "recipe_application_${var.shortname}"
  version      = "1.0.0"
  parent_image = tolist(aws_imagebuilder_image.image_installation.output_resources[0].amis)[0].image

  dynamic "component" {
    for_each = local.component_arns_app_setup
    content {
      component_arn = component.value
    }
  }
}
## --------------------------------------------------------------------------------------------------------------------