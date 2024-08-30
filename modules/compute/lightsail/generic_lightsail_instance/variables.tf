variable "codedeploy" {
  type = any
}

variable "domain" {
  description = "Domínio base da aplicação"
  type        = string
}

variable "ec2_ssh_keypair_name" {
  type = string
}

variable "lightsail_tag_name" {
  description = "Value os tage Name os lightsail instance"
  type        = string
}

variable "project_bucket_name" {
  type        = string
  description = "Bucket name onde está o remote state"
}

variable "region" {
  description = "Região onde a infraestrutura será criada."
  type        = string
}

variable "shortname" {
  description = "Nome curto para identificação dos recursos na AWS"
  type        = string
}
