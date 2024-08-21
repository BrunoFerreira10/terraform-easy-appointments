output "certificate" {
  description = "ACM Certificate information"
  value = nonsensitive(module.acm_ssl.certificate)
}