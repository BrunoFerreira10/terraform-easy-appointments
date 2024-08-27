resource "aws_vpc_endpoint" "codedeploy" {
  vpc_id            = var.vpc.id
  service_name      = "com.amazonaws.${var.region}.codedeploy-commands-secure"
  
  security_group_ids = [
    module.sg_vpc_endpoint_codedeploy_rules.security_group.id
  ]

  private_dns_enabled = true
}