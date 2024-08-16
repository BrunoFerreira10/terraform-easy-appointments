#### Start default project github vars ####
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

variable "S3_LOGGING_BUCKET_NAME" {
  type = string
}