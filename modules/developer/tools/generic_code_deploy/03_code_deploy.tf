resource "aws_codedeploy_app" "this" {
  name = "${var.shortname}-codedeploy-app"
}

resource "aws_codedeploy_deployment_group" "this" {
  app_name              = aws_codedeploy_app.this.name
  deployment_group_name = "${var.shortname}-deployment-group"
  service_role_arn      = aws_iam_role.codedeploy.arn

  deployment_config_name = "CodeDeployDefault.AllAtOnce"

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      value = "${var.shortname}-ec2-instance"
      type  = "KEY_AND_VALUE"
    }
  }

  load_balancer_info {
    elb_info {
      # name = var.elb_name
    }
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  alarm_configuration {
    enabled = false
  }
}
