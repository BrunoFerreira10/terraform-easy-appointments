resource "aws_lightsail_domain" "this" {
  domain_name = var.domain
}

resource "aws_lightsail_domain_entry" "this" {
  domain_name = aws_lightsail_domain.this.domain_name
  type        = "A"
  name        = ""
  target      = aws_lightsail_static_ip.this.ip_address
}

resource "aws_lightsail_domain_entry" "www" {
  domain_name = aws_lightsail_domain.this.domain_name
  type        = "CNAME"
  name        = "www"
  target      = aws_lightsail_domain_entry.this.domain_name
}

resource "aws_lightsail_domain_entry" "test" {
  domain_name = aws_lightsail_domain.this.domain_name
  type        = "CNAME"
  name        = "test"
  target      = aws_lightsail_domain_entry.this.domain_name
}