module "elasticache" {
  source = "terraform-aws-modules/elasticache/aws"

  # Replication group (cluster) settings
  replication_group_id   = "${var.app_name}-cluster-redis"
  description            = "${var.app_name} replication group"
  engine                 = "valkey"
  engine_version         = "7.2"
  node_type              = "cache.t4g.micro"
  port                   = 6379

  vpc_id                 = var.vpc_id

  # Subnet Group
  subnet_ids = var.subnet_ids
  create_subnet_group         = true

  # Cluster configuration (non-clustered mode with single node)
  num_cache_clusters     = 1
  cluster_mode_enabled   = false
  automatic_failover_enabled = false # Mandatory for single-node

  # Security and parameters
  parameter_group_name   = "default.valkey7"
  security_group_ids     = [var.elasticache_sg_id]
}

data "aws_elasticache_replication_group" "cache" {
  replication_group_id = "${var.app_name}-cluster-redis"

  # 👇 This forces Terraform to wait for the module to finish creating it
  depends_on = [module.elasticache]
}