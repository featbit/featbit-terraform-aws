# -------------------------------------------
# ECS CLUSTER
# -------------------------------------------

resource "aws_ecs_cluster" "main" {
  name = "${var.app_name}-ecs-cluster"
}

# UI
resource "aws_ecs_task_definition" "ui" {
  family                   = "${var.app_name}-ui-ecs-task"
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  container_definitions = jsonencode([{
    name      = "ui"
    image     = "featbit/featbit-ui:${var.featbit_version}"
    networkMode = "awsvpc"
    logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-group" = "/ecs/${var.app_name}-ui-log-group",
          "awslogs-region" = "${var.region}",
          "awslogs-stream-prefix" = "ecs"
        }
    }
    portMappings = [{
      containerPort = var.ui_port
      hostPort      = var.ui_port
    }]
    environment = [
      {
        name:"awslogs-stream-prefix",
        value:"ecs"
      },
      {
        name  = "API_URL"
        value = "http://api.${var.domain_name}"
      },
      {
        name  = "DEMO_URL"
        value = "https://featbit-samples.vercel.app"
      },
      {
        name  = "EVALUATION_URL"
        value = "http://eval.${var.domain_name}"
      }
    ]
  }])
}

resource "aws_ecs_service" "ui" {
  name                      = "${var.app_name}-ui-ecs-service"
  cluster                   = aws_ecs_cluster.main.id
  task_definition           = aws_ecs_task_definition.ui.arn
  desired_count             = "1"
  launch_type               = "FARGATE"
  force_new_deployment      = true

  network_configuration {
    security_groups  = [var.ecs_tasks_sg_id]
    subnets          = var.ecs_subnet_ids
    assign_public_ip = "true"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.ui_target.id
    container_name   = "ui"
    container_port   = var.ui_port
  }
  depends_on = [aws_lb_listener.main]
}

# api
resource "aws_ecs_task_definition" "api" {
  family                   = "${var.app_name}-api-ecs-task"
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  container_definitions = jsonencode([{
    name      = "api"
    image     = "featbit/featbit-api-server:${var.featbit_version}"
    networkMode = "awsvpc"
    logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-group" = "/ecs/${var.app_name}-api-log-group",
          "awslogs-region" = "${var.region}",
          "awslogs-stream-prefix" = "ecs"
        }
    }
    portMappings = [{
      containerPort = var.api_port
      hostPort      = var.api_port
    }]
    environment = [
        {
          name:"awslogs-stream-prefix",
          value:"ecs"
        },
        {
          name  = "DbProvider"
          value = "Postgres"
        },
        {
          name  = "MqProvider"
          value = "Redis"
        },
        {
          name  = "CacheProvider"
          value = "Redis"
        },
        {
          name  = "Postgres__ConnectionString"
          value = "Host=${var.db_host};Port=${var.db_port};Username=${var.db_username};Password=${var.db_password};Database=featbit"
        },
        {
          name  = "Redis__ConnectionString"
          value = "${var.cache_host}:${var.cache_port},ssl=true"
        },
        {
          name  = "OLAP__ServiceHost"
          value = "http://da.${var.domain_name}"
        }
      ]
  }])
}

resource "aws_ecs_service" "api" {
  name                      = "${var.app_name}-api-ecs-service"
  cluster                   = aws_ecs_cluster.main.id
  task_definition           = aws_ecs_task_definition.api.arn
  desired_count             = "1"
  launch_type               = "FARGATE"
  force_new_deployment      = true

  network_configuration {
    security_groups  = [var.ecs_tasks_sg_id]
    subnets          = var.ecs_subnet_ids
    assign_public_ip = "true"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.api_target.id
    container_name   = "api"
    container_port   = var.api_port
  }
  depends_on = [aws_lb_listener.main]
}

# eval
resource "aws_ecs_task_definition" "eval" {
  family                   = "${var.app_name}-eval-ecs-task"
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  container_definitions = jsonencode([{
    name      = "eval"
    image     = "featbit/featbit-evaluation-server:${var.featbit_version}"
    networkMode = "awsvpc"
    logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-group" = "/ecs/${var.app_name}-eval-log-group",
          "awslogs-region" = "${var.region}",
          "awslogs-stream-prefix" = "ecs"
        }
    }
    portMappings = [{
      containerPort = var.eval_port
      hostPort      = var.eval_port
    }]
    environment = [
      {
          name:"awslogs-stream-prefix",
          value:"ecs"
        },
        {
          name  = "DbProvider"
          value = "Postgres"
        },
        {
          name  = "MqProvider"
          value = "Redis"
        },
        {
          name  = "CacheProvider"
          value = "Redis"
        },
        {
          name  = "Postgres__ConnectionString"
          value = "Host=${var.db_host};Port=${var.db_port};Username=${var.db_username};Password=${var.db_password};Database=featbit"
        },
        {
          name  = "Redis__ConnectionString"
          value = "${var.cache_host}:${var.cache_port},ssl=true"
        }
      ]
  }])
}

resource "aws_ecs_service" "eval" {
  name                      = "${var.app_name}-eval-ecs-service"
  cluster                   = aws_ecs_cluster.main.id
  task_definition           = aws_ecs_task_definition.eval.arn
  desired_count             = "1"
  launch_type               = "FARGATE"
  force_new_deployment      = true

  network_configuration {
    security_groups  = [var.ecs_tasks_sg_id]
    subnets          = var.ecs_subnet_ids
    assign_public_ip = "true"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.eval_target.id
    container_name   = "eval"
    container_port   = var.eval_port
  }
  depends_on = [aws_lb_listener.main]
}

# da
resource "aws_ecs_task_definition" "da" {
  family                   = "${var.app_name}-da-ecs-task"
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  #container_definitions    = data.template_file.da.rendered
  container_definitions = jsonencode([{
    name      = "da"
    image     = "featbit/featbit-data-analytics-server:${var.featbit_version}"
    networkMode = "awsvpc"
    logConfiguration = {
        logDriver = "awslogs",
        options = {
          "awslogs-group" = "/ecs/${var.app_name}-da-log-group",
          "awslogs-region" = "${var.region}",
          "awslogs-stream-prefix" = "ecs"
        }
    }
    portMappings = [{
      containerPort = var.da_port
      hostPort      = var.da_port
    }]
    environment = [
      {
          name:"awslogs-stream-prefix",
          value:"ecs"
        },
        {
          name  = "DB_PROVIDER"
          value = "Postgres"
        },
        {
          name  = "POSTGRES_USER"
          value = "${var.db_username}"
        },
        {
          name  = "POSTGRES_PASSWORD"
          value = "${var.db_password}"
        },
        {
          name  = "POSTGRES_HOST"
          value = "${var.db_host}"
        },
        {
          name  = "POSTGRES_PORT"
          value = tostring(var.db_port)
        },
        {
          name  = "POSTGRES_DATABASE"
          value = "featbit"
        },
        {
          name  = "CHECK_DB_LIVNESS"
          value = "true"
        }
      ]
  }])
}

resource "aws_ecs_service" "da" {
  name                      = "${var.app_name}-da-ecs-service"
  cluster                   = aws_ecs_cluster.main.id
  task_definition           = aws_ecs_task_definition.da.arn
  desired_count             = "1"
  launch_type               = "FARGATE"
  force_new_deployment      = true

  network_configuration {
    security_groups  = [var.ecs_tasks_sg_id]
    subnets          = var.ecs_subnet_ids
    assign_public_ip = "true"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.da_target.id
    container_name   = "da"
    container_port   = var.da_port
  }
  depends_on = [aws_lb_listener.main]
}

