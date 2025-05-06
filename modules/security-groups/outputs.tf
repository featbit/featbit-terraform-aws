output "elasticache_sg_id" {
  value = aws_security_group.elasticache_sg.id
}

output "aurora_sg_id" {
  value = aws_security_group.aurora_sg.id
}

output "lb_sg_id" {
  value = aws_security_group.lb.id
}

output "ecs_tasks_sg_id" {
  value = aws_security_group.ecs_tasks.id
}
