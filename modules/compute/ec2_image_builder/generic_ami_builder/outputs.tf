output "golden_image" {
  description = "ID da Golden Image Information"
  value       = tolist(aws_imagebuilder_image.application.output_resources[0].amis)[0].image
}