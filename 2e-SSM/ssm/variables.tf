variable "shortname" {
  type        = string
  description = "Nome curto para identificacao dos recursos"
}

variable "GITHUB_SECRETS" {
  type = map(string)
}