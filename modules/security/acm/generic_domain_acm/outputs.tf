output "certificate" {
  description = "ACM Certificate information"
  value = nonsensitive(aws_acm_certificate.certificate)
}