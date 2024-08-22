## Required variables
variable "acm_certificate" {
  description = "ACM certificate for load balance HTTPS"
  type        = any
}

variable "domain" {
  description = "Domínio base da aplicação"
  type        = string
}

variable "ec2_ssh_keypair_name" {
  description = "Key pair name for EC2 ssh access"
  type        = string
}

variable "ami_image_id" {
  description = "Image AMI for launch template"
  type        = string
}

variable "shortname" {
  description = "Nome curto para identificacao dos recursos"
  type        = string
}

variable "vpc" {
  description = "VPC for ELB allocation"
  type        = any
}

variable "sg_elb_rules" {
  description = "Rules for ELB security group"
  type        = any
}

variable "sg_launch_tpl_rules" {
  description = "Rules Launch Template (instances) security group"
  type        = any
}

## Optional variables
variable "instance_type" {
  description = "Instance type for Load Balancer"
  type        = string
  default     = "t3.micro"
}

