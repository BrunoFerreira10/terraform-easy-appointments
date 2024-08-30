output "lightsail_static_ip" {
  description = "Light sail static ip information"
  value = module.lightsail_app_domain.lightsail_static_ip
}