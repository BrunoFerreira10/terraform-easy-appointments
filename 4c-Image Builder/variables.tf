#### Start default project github vars ####
variable "GENERAL_TAG_PROJECT" {
  type        = string
  description = "Descrição do projeto."
}

variable "GENERAL_TAG_CUSTOMER" {
  type        = string
  description = "Cliente do projeto."
}

variable "GENERAL_TAG_AUTHOR" {
  type        = string
  description = "Autor de edição."
}

variable "GENERAL_TAG_SHORTNAME" {
  type        = string
  description = "Nome curto para identificação dos recursos na AWS"
}

variable "GENERAL_REGION" {
  type        = string
  description = "Região onde a infraestrutura será criada."
}

variable "GENERAL_PROJECT_BUCKET" {
  type        = string
  description = "Bucket name onde está o remote state"
}
#### End default project github vars ####

variable "RT53_DOMAIN" {
  type        = string
  description = "Domínio da aplicação"
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