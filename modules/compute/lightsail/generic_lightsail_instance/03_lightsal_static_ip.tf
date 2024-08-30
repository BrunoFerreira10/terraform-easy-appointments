resource "aws_lightsail_static_ip_attachment" "this" {
  static_ip_name = var.lightsail_static_ip.id
  instance_name  = aws_lightsail_instance.this.id
}