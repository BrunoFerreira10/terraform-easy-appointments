resource "aws_codedeploy_app" "this" {
  name = "${var.codedeploy_settings.application_name}"
}

resource "aws_codedeploy_deployment_group" "this" {
  app_name              = aws_codedeploy_app.this.name
  deployment_group_name = "${var.codedeploy_settings.application_name}"
  service_role_arn      = aws_iam_role.codedeploy.arn

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "IN_PLACE"
  }

  load_balancer_info {
    elb_info {
      name = var.codedeploy_settings.elb.name  # Nome do ELB que já está configurado para suas instâncias EC2
    }
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]  # Rollback automático em caso de falha no deployment
  }

  # ec2_tag_set {
  #   ec2_tag_filter {
  #     key   = "Name"
  #     value = "${var.shortname}-ec2-instance"
  #     type  = "KEY_AND_VALUE"
  #   }
  # }

  # trigger_configuration {
  #   trigger_events     = ["DeploymentFailure"]
  #   trigger_name       = "${var.shortname}-codedeploy-trigger"
  #   trigger_target_arn = aws_sns_topic.this.arn  # Supondo que você tenha um SNS para notificações
  # }
}
