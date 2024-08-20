variable "region" {
  description = "Região onde a infraestrutura será criada."
  type        = string
}

variable "ec2_ssh_keypair_name" {
  type = string
}

variable "vpc" {
  description = "VPC that will allocate the bastion host security group"
  type        = any
}
