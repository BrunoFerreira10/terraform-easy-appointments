output "image-builder-golden-ami-id" {
  description = "ID da Golden AMI criada pelo Image Builder"
  value       = module.image-builder-1.golden-ami-id
}