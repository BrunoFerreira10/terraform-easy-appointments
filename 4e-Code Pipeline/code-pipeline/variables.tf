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

variable "RDS_1_DB_NAME" {
  type        = string
  description = "DB Name do RDS 1"
}

variable "RDS_1_DB_USERNAME" {
  type        = string
  description = "DB User name do RDS 1"
}