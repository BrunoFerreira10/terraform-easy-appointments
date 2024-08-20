variable "region" {
  type        = string
  description = "Região onde a infraestrutura será criada."
}

variable "remote-state-bucket" {
  type        = string
  description = "Bucket name onde está o remote state"
}

variable "shortname" {
  type        = string
  description = "Nome curto para identificacao dos recursos"
}

variable "RT53_DOMAIN" {
  type        = string
  description = "Domínio base da aplicação"
}

variable "EC2_SSH_KEYPAIR_NAME" {
  type = string
}

variable "IMAGE_BUILDER_PARENT_IMAGE" {
  type = string
}

variable "APP_REPOSITORY_URL" {
  type = string
}

variable "RDS_1_DB_NAME" {
  type = string
}

variable "RDS_1_DB_USERNAME" {
  type = string
}