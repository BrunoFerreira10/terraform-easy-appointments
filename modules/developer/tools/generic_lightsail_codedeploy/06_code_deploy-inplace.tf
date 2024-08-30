resource "aws_codedeploy_app" "this" {
  name = "${var.codedeploy_settings.application_name}"

  tags = {
    Name        = "${var.codedeploy_settings.application_name}"
    # Environment = var.environment
  }
}

resource "aws_codedeploy_deployment_group" "this" {
  app_name              = aws_codedeploy_app.this.name
  deployment_group_name = "${var.codedeploy_settings.application_name}"
  service_role_arn      = aws_iam_role.codedeploy.arn

  deployment_style {
    deployment_option = "WITHOUT_TRAFFIC_CONTROL"
    deployment_type   = "IN_PLACE"
  }

  on_premises_instance_tag_filter{
    key   = "Name"
    value = "ltsail_easy_appointments"
    type  = "KEY_AND_VALUE"
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  tags = {
    Name = "${var.codedeploy_settings.application_name}"
  }
}
