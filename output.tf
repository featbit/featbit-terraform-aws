# output "instance_id" {
#   description = "ID of the EC2 instance"
#   value       = aws_instance.app_server.id
# }

# output "instance_public_ip" {
#   description = "Public IP address of the EC2 instance"
#   value       = aws_instance.app_server.public_ip
# }

output "db_host" {
  value = module.database.db_host
}

output "db_port" {
  value = module.database.db_port
}

output "cache_host" {
  value = module.elasticache.cache_host
}

output "cache_port" {
  value = module.elasticache.cache_port
}

output "jumphost_public_ip" {
  value = module.jumphost.jumphost_public_ip
}

output "load_balancer_dns" {
  value = module.ecs.load_balancer_dns
}