variable "ec2_ssh_keypair_name" {
  type = string
}

variable "region" {
  description = "Região onde a infraestrutura será criada."
  type        = string
}

variable "shortname" {
  description = "Nome curto para identificação dos recursos na AWS"
  type        = string
}

variable "vpc" {
  description = "VPC that will allocate the bastion host security group"
  type        = any
}

variable "sg_bastion_rules" {
  description = "Rules for bastion host security group"
  type        = tomap(any)
}