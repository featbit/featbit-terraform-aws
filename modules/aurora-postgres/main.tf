# DB Subnet Group
resource "aws_db_subnet_group" "this" {
  name       = "${var.app_name}-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = var.vpc_tags
}

module "aurora_postgres" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "9.13.0"

  name = "${var.app_name}-aurora-postgres"

  engine         = "aurora-postgresql"
  engine_version = "15.10"
  instance_class = "db.r6g.large"

  vpc_id                 = var.vpc_id
  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.aurora_sg_id]

  master_username = var.db_username

  # if you want kms to generate the password, set manage_master_user_password = true and remove master_password
  manage_master_user_password = false
  master_password             = var.db_password

  database_name = "featbit"

  backup_retention_period      = 7
  preferred_backup_window      = "03:00-06:00"
  preferred_maintenance_window = "Mon:06:00-Mon:07:00"

  storage_encrypted   = true
  monitoring_interval = 60 # Enable enhanced monitoring (seconds)

  apply_immediately   = true # optional
  skip_final_snapshot = true # during destroy (dev only)

  instances = {
    one = {
      instance_class      = "db.r8g.large"
      #publicly_accessible = true
    }
    # You can add more instances (read replicas) here
  }

  tags = var.vpc_tags
}