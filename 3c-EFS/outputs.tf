output "efs-efs-1-dns-name" {
  description = "DNS Name do filesystem para montar /etc/opt"
  value       = module.efs.efs-1-dns-name
}