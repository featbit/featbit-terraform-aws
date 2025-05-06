variable "app_name" {
  description = "Name of the APP"
  type        = string
  default     = "featbit"
}

variable "vpc_id" {
  description = "The id of the vpc"
  type        = string
}

variable "jumphost_sg_id" {
  description = "The id of the vpc"
  type        = string
}

variable "vpc_tags" {
  description = "Tags to apply to resources created by VPC module"
  type        = map(string)
}

variable "subnet_ids" {
  description = "Subnets for db"
  type        = list(string)
}

variable "elasticache_sg_id" {}