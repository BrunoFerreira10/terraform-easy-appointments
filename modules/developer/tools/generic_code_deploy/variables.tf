variable "app_repository_url" {
  type = string
}

variable "codebuild_settings" {
  description = "Codebuild project settings"
  type = object({
    project_name = string
  })
}

variable "github_connection" {
  description = "Github connection to user account"
  type = any
}

variable "project_bucket_name" {
  description = "Project bucket name"
  type = string
}

variable "region" {
  description = "Região onde a infraestrutura está alocada"
  type = string
}

variable "shortname" {
  description = "Nome curto para identificação dos recursos na AWS"
  type        = string
}