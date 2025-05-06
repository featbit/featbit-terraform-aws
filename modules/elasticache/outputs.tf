output "cache_host" {
  value = data.aws_elasticache_replication_group.cache.primary_endpoint_address
}

output "cache_port" {
  value = data.aws_elasticache_replication_group.cache.port
}