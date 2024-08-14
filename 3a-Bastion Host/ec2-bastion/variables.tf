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

# variable "ec2-ssh-private-key" {
#   description = "Chave privada SSH para conexão"
#   type        = string
#   sensitive   = true
# }