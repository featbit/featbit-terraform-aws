variable "app_name" {
  description = "Name of the APP"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID to attach security group"
  type        = string
}

variable "region" {}

variable "ecs_subnet_ids" {
  description = "Subnets for ecs"
  type        = list(string)
}

variable "lb_subnet_ids" {
  description = "Subnets for load balancer"
  type        = list(string)
}

variable "jumphost_sg_id" {
  description = "The id of the vpc"
  type        = string
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

variable "da_port" {
  description = "Port exposed by the docker image to redirect traffic to"
}

variable "db_username" {}

variable "db_password" {}

variable "domain_name" {}

variable "db_host" {}

variable "db_port" {}

variable "cache_host" {}

variable "cache_port" {}

variable "lb_sg_id" {}

variable "ecs_tasks_sg_id" {}

variable "featbit_version" {}