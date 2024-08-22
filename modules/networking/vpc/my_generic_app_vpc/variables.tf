variable "region" {
  type        = string
  description = "Região onde a infraestrutura será criada."
}

variable "shortname" {
  type        = string
  description = "Nome curto para identificacao dos recursos"
}

variable "vpc_settings" {
  description = "Configurações da VPC."
  type = object({
    nacl_rules = map(object({
      ingress = map(object({
        rule_number = number
        cidr        = string
        port        = optional(number)
        from_port   = optional(number)
        to_port     = optional(number)
      }))
      egress = map(object({
        rule_number = number
        cidr        = string
        port        = optional(number)
        from_port   = optional(number)
        to_port     = optional(number)
      }))
    }))
  })
}
