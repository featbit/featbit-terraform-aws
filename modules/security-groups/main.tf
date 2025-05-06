
# -------------------------------------------
# ECS / Load balancer Security Group
# -------------------------------------------

# lb Security Group: Edit to restrict access to the application
resource "aws_security_group" "lb" {
  name        = "${var.app_name}-load-balancer-securitygroup"
  description = "controls access to the lb"
  vpc_id      = var.vpc_id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Http from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app_name}-load-balancer-securitygroup"
  }
}

# -------------------------------------------
# ECS / Task Security Group
# -------------------------------------------

# Traffic to the ECS cluster should only come from the lb
resource "aws_security_group" "ecs_tasks" {
  name        = "${var.app_name}-ecs-securitygroup"
  description = "allow inbound access from the lb only"
  vpc_id      = var.vpc_id

  # both ui and da server use the same port, so we only need to define the ingress rule once
  ingress {
    description     = "ui & da"
    protocol        = "tcp"
    from_port       = var.ui_port
    to_port         = var.ui_port
    security_groups = [aws_security_group.lb.id, var.jumphost_sg_id]
  }

  ingress {
    description     = "api"
    protocol        = "tcp"
    from_port       = var.api_port
    to_port         = var.api_port
    security_groups = [aws_security_group.lb.id, var.jumphost_sg_id]
  }

  ingress {
    description     = "eval"
    protocol        = "tcp"
    from_port       = var.eval_port
    to_port         = var.eval_port
    security_groups = [aws_security_group.lb.id, var.jumphost_sg_id]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app_name}-ecs-securitygroup"
  }
}

# -------------------------------------------
# Database Security Group
# -------------------------------------------
resource "aws_security_group" "aurora_sg" {
  name        = "${var.app_name}-aurora-sg"
  description = "Security group for Aurora PostgreSQL"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow access from private subnets and jumphost"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    security_groups = [var.jumphost_sg_id, aws_security_group.ecs_tasks.id]
    #cidr_blocks = ["0.0.0.0/0"] # TODO replace with var.vpc_private_subnets
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.vpc_tags
}

# -------------------------------------------
# Elasticache Security Group
# -------------------------------------------
resource "aws_security_group" "elasticache_sg" {
  name        = "${var.app_name}-elasticache-sg"
  description = "Security group for Elasticache"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow access from private subnets and jumphost"
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    security_groups = [var.jumphost_sg_id, aws_security_group.ecs_tasks.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.vpc_tags
}