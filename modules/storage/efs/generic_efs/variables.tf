variable "mount_target_subnets" {
  description = "Subnets where EFS need create mount points"
  type        = list(string)
}

variable "shortname" {
  description = "Nome curto para identificacao dos recursos"
  type        = string
}

variable "vpc" {
  description = "VPC for EFS allocations"
  type        = any
}
