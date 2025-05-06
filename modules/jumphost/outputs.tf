output "sg_id" {
  value = aws_security_group.jumphost.id
}

output "jumphost_public_ip" {
  value = module.ec2_instances[0].public_ip
}