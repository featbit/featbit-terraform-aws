output "db_host" {
  value = module.aurora_postgres.cluster_endpoint
}

output "db_port" {
  value = module.aurora_postgres.cluster_port
}