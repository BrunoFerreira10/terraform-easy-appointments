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

variable "EC2_SSH_KEYPAIR_NAME" {
  type = string
}

variable "RT53_DOMAIN" {
  type = string
}