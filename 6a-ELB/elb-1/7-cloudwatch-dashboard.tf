resource "aws_cloudwatch_dashboard" "dashboard-1" {
  dashboard_name = "Application-Dashboard"

  dashboard_body = jsonencode({
    widgets = [
      # Titulo
      {
        type   = "text"
        x      = 0
        y      = 0
        width  = 24
        height = 1

        properties = {
          markdown = "## Applicaton Dashboard"
        }
      },
      # Painel EC2 CPU Utilization
      {
        type   = "metric"
        x      = 0
        y      = 1
        width  = 6
        height = 4

        properties = {
          metrics = [
            [
              "AWS/EC2",
              "CPUUtilization",
              "AutoScalingGroupName",
              aws_autoscaling_group.asg-alb-1.name
            ]
          ]
          period = 60
          stat   = "Average"
          region = "${var.region}"
          title  = "Auto Scaling Group - CPU Utilization"
        }
      },
      # Painel ELB Instances
      {
        type   = "metric"
        x      = 6
        y      = 1
        width  = 6
        height = 4

        properties = {
          metrics = [
            [
              "AWS/AutoScaling",
              "GroupTotalInstances",
              "AutoScalingGroupName",
              aws_autoscaling_group.asg-alb-1.name
            ]
          ]
          period = 60
          stat   = "Sum"
          region = "${var.region}"
          title  = "Auto Scaling Group - Group Total Instances"
        }
      },
      # Painel ELB Requests
      {
        type   = "metric"
        x      = 12
        y      = 1
        width  = 6
        height = 4

        properties = {
          title  = "ELB - Requests"
          region = "${var.region}"
          stat   = "Sum"
          period = 60
          metrics = [
            [
              "AWS/ApplicationELB",
              "RequestCount",
              "TargetGroup",
              aws_lb_target_group.tgrp-1-alb-1.arn_suffix,
              "LoadBalancer",
              aws_lb.alb-1.arn_suffix
            ]
          ]
        }
      }
      ,
      # Painel ELB Network In
      {
        type   = "metric"
        x      = 18
        y      = 1
        width  = 6
        height = 4

        properties = {
          metrics = [
            [
              "AWS/EC2",
              "NetworkIn",
              "AutoScalingGroupName",
              aws_autoscaling_group.asg-alb-1.name
            ]
          ]
          period = 60
          stat   = "Average"
          region = "${var.region}"
          title  = "Auto Scaling Group - Network In"
        }
      }
    ]
  })
}