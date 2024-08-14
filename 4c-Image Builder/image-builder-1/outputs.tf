output "golden-ami-id" {
  description = "ID da Golden AMI criada pelo Image Builder"
  value       = tolist(aws_imagebuilder_image.image-3.output_resources[0].amis)[0].image
}