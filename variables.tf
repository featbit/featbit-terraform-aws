variable "region" {
  default = "us-west-2"
}

variable "app_name" {
  description = "Name of the APP"
  type        = string
  default     = "featbit"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_azs" {
  description = "Availability zones for VPC"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b"]
}

variable "vpc_private_subnets" {
  description = "Private subnets for VPC"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "vpc_public_subnets" {
  description = "Public subnets for VPC"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "vpc_tags" {
  description = "Tags to apply to resources created by VPC module"
  type        = map(string)
  default = {
    Terraform   = "true"
    Environment = "prod"
    App = "featbit"
  }
}

variable "db_username" {
  description = "The database usename"
  type        = string
  default     = "postgres"
}

variable "db_password" {
  description = "The database password"
  type        = string
  default     = "please_change_me"
}

variable "key_pair" {
  description = "The key pair used to connect to the ec2 jumphost instance"
  type        = string
  default     = "featbit"
}

variable "domain_name" {
  description = "The domain name"
  type        = string
  default     = "example.com"
}

variable "featbit_version" {
  description = "The FeatBit version"
  type        = string
  default     = "5.0.2"
}