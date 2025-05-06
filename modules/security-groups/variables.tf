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

variable "ui_port" {
  description = "Port exposed by the docker image to redirect traffic to"
}

variable "api_port" {
  description = "Port exposed by the docker image to redirect traffic to"
}

variable "eval_port" {
  description = "Port exposed by the docker image to redirect traffic to"
}