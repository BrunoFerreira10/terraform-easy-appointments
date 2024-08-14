variable "regiao" {
  type        = string
  description = "Região onde a infraestrutura será criada."
}

variable "remote-state-bucket" {
  type        = string
  description = "Bucket name onde está o remote state"
}

variable "rds-1-db-name" {
  type        = string
  description = "DB Name do RDS 1"
}

variable "rds-1-db-username" {
  type        = string
  description = "DB User name do RDS 1"
}

variable "rds-1-db-password" {
  type        = string
  description = "DB Password do RDS 1"
  sensitive   = true
}
