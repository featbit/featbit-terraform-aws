# VPC Module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  name = var.vpc_name
  cidr = var.vpc_cidr
  azs  = var.vpc_azs

  # Private subnets
  private_subnets = var.vpc_private_subnets

  # Public subnets (required for NAT)
  public_subnets  = var.vpc_public_subnets

  # NAT Gateway configuration
  enable_nat_gateway     = true
  single_nat_gateway     = false
  one_nat_gateway_per_az = true

  tags               = var.vpc_tags
}