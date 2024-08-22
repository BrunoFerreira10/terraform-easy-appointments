// Auto-scaling
resource "aws_autoscaling_group" "this" {

  name = replace("asg-${var.shortname}","_","-")

  tag {
    key                 = "Name"
    value               = "asg_${var.shortname}"
    propagate_at_launch = true
  }

  // Group Details  
  capacity_rebalance = true
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  lifecycle {
    create_before_destroy = true
  }

  // Launch template
  launch_template {
    id      = aws_launch_template.this.id
    version = "1"
  }

  // Instance refresh
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 100
      max_healthy_percentage = 100
      skip_matching          = false
    }
  }

  // Network
  vpc_zone_identifier = [
    for subnet in var.vpc.subnets.private :
    subnet.id
  ]

  // Load balancing
  target_group_arns = [
    aws_lb_target_group.this.arn
  ]

  // Health checks
  health_check_type         = "ELB"
  health_check_grace_period = 60

  // Advanced configuration
  default_cooldown = 180

  // Metrics
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]

  metrics_granularity = "1Minute"

}

resource "aws_autoscaling_policy" "add_instance" {
  name                   = "cpu_limit_add_instance"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.this.name
}

resource "aws_autoscaling_policy" "remove_instance" {
  name                   = "cpu_limit_remove_instance"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.this.name
}