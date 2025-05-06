provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"

  vpc_name = "${var.app_name}-vpc"
  vpc_cidr = var.vpc_cidr

  vpc_azs             = var.vpc_azs
  vpc_private_subnets = var.vpc_private_subnets
  vpc_public_subnets  = var.vpc_public_subnets

  vpc_tags = var.vpc_tags
}

module "jumphost" {
  source = "./modules/jumphost"

  subnet_id = module.vpc.public_subnets[0]
  key_pair  = var.key_pair

  app_name = var.app_name
  vpc_id   = module.vpc.vpc_id
}

module "sg" {
  source = "./modules/security-groups"

  app_name = var.app_name

  vpc_id   = module.vpc.vpc_id
  vpc_tags = var.vpc_tags

  jumphost_sg_id = module.jumphost.sg_id
  ui_port        = 80
  api_port       = 5000
  eval_port      = 5100
}

module "elasticache" {
  source = "./modules/elasticache"

  app_name = var.app_name
  vpc_id   = module.vpc.vpc_id
  vpc_tags = var.vpc_tags

  subnet_ids        = module.vpc.private_subnets
  jumphost_sg_id    = module.jumphost.sg_id
  elasticache_sg_id = module.sg.elasticache_sg_id
}

module "database" {
  source = "./modules/aurora-postgres"

  app_name = var.app_name

  vpc_id   = module.vpc.vpc_id
  vpc_tags = var.vpc_tags

  db_username = var.db_username
  db_password = var.db_password

  subnet_ids     = module.vpc.private_subnets
  jumphost_sg_id = module.jumphost.sg_id
  aurora_sg_id   = module.sg.aurora_sg_id
}

module "ecs" {
  source = "./modules/ecs-services"

  app_name        = var.app_name
  region          = var.region
  vpc_id          = module.vpc.vpc_id
  lb_subnet_ids   = module.vpc.public_subnets
  ecs_subnet_ids  = module.vpc.private_subnets
  jumphost_sg_id  = module.jumphost.sg_id
  domain_name     = var.domain_name
  lb_sg_id        = module.sg.lb_sg_id
  ecs_tasks_sg_id = module.sg.ecs_tasks_sg_id

  db_host     = module.database.db_host
  db_port     = module.database.db_port
  cache_host  = module.elasticache.cache_host
  cache_port  = module.elasticache.cache_port
  db_username = var.db_username
  db_password = var.db_password

  ui_port   = 80
  api_port  = 5000
  eval_port = 5100
  da_port   = 80

  featbit_version = var.featbit_version

  depends_on = [module.elasticache, module.database]
}