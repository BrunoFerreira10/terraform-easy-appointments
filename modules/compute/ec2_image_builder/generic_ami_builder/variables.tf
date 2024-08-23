variable "region" {
  description = "Região onde a infraestrutura será criada."
  type        = string
}

variable "shortname" {
  description = "Nome curto para identificacao dos recursos"
  type        = string
}

variable "domain" {
  type        = string
  description = "Domínio base da aplicação"
}

variable "ec2_ssh_keypair_name" {
  type = string
}

variable "installation_parent_image" {
  type = string
}

variable "app_repository_url" {
  type = string
}

variable "vpc" {
  type = any
}

variable "rds" {
  type = any
}

variable "sg_img_builder_instance_rules" {
  description = "Rules for image builder instance security group"
  type        = any
}