variable "name_prefix" {
  type = string
  description = "Prefix for named resources"
  default =  ""
}

variable "name" {
  type = string
  description = "LoadBalancer name"
}

variable "vpc" {
  type = string
  description = "VPC ID"
}

variable "subnets" {
  type = list(string)
  description = "Subnet IDs"
}

variable "default_certificate" {
  type = string
  description = "Default certificate ARN"
}

variable "additional_security_groups" {
  type = list(string)
  description = "Security group IDs"
  default = []
}