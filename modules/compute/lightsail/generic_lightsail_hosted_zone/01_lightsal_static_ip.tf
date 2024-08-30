resource "aws_lightsail_static_ip" "this" {
  name = "sip_${var.shortname}"
}