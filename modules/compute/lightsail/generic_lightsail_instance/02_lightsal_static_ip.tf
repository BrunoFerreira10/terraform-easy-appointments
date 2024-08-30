resource "aws_lightsail_static_ip" "this" {
  name = "sip_${var.shortname}"
}

resource "aws_lightsail_static_ip_attachment" "this" {
  static_ip_name = aws_lightsail_static_ip.this.id
  instance_name  = aws_lightsail_instance.this.id
}