resource "aws_lb" "this" {
  name               = "elb_${var.shortname}"
  internal           = false
  load_balancer_type = "application"
  security_groups = [
    aws_security_group.elb.id
  ]
  subnets = [
    var.vpc.subnets.private[*].id
  ]

  enable_deletion_protection = false

  tags = {
    Name = "elb_${var.shortname}"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  tags = {
    Name = "listener_http_${var.shortname}"
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.this.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = var.acm_certificate.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }

  tags = {
    Name = "listener_https_${var.shortname}"
  }
}

