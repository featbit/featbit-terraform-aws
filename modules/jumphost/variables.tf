variable "app_name" {
  description = "Name of the APP"
  type        = string
}

variable "vpc_id" {
  description = "The id of the vpc"
  type        = string
}

variable "subnet_id" {
  description = "Subnet for ec2 instance"
  type        = string
}

variable "key_pair" {
  description = "The key pair used to connect to the ec2 jumphost instance"
  type        = string
}