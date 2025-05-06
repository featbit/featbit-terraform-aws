resource "aws_security_group" "jumphost" {
  name = "${var.app_name}-jumphost-securitygroup"
  description = "allow inbound ssh access from the internet"
  vpc_id      = var.vpc_id

  # Postgress
  ingress {
    protocol        = "tcp"
    from_port       = 5432
    to_port         = 5432
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Redis
  ingress {
    protocol        = "tcp"
    from_port       = 6379
    to_port         = 6379
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description     = "SSH"
    protocol        = "tcp"
    from_port       = 22
    to_port         = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app_name}-jumphost-securitygroup"
  }
}

data "aws_key_pair" "key" {
  key_name = var.key_pair
}

module "ec2_instances" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.3.0"
  count   = 1

  name = "FeatBit Jumphost Server"

  ami                    = "ami-0c5204531f799e0c6"
  instance_type          = "t3.nano"
  vpc_security_group_ids = [aws_security_group.jumphost.id]
  subnet_id              = var.subnet_id
  key_name = data.aws_key_pair.key.key_name

  associate_public_ip_address = true

  tags = {
    Terraform   = "true"
    Name = "FeatBit Jumphost Server"
  }
}