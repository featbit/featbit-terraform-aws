# -------------------------------------------
# This file define the load balancer and target groups for the cluster
# -------------------------------------------

# Define the main load balancer
resource "aws_lb" "main" {
  name            = "${var.app_name}-main-lb"
  subnets         = var.lb_subnet_ids
  internal        = "false"
  load_balancer_type = "application"
  idle_timeout    = 90
  security_groups = [var.lb_sg_id]
}

# -------------------------------------------
# Target groups for the main load balancer
# including: ui, api, eval and da
# -------------------------------------------

resource "aws_lb_target_group" "ui_target" {
  name        = "${var.app_name}-ui-lb-tg"
  port        = var.ui_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
  
  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/health"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group" "api_target" {
  name        = "${var.app_name}-api-lb-tg"
  port        = var.api_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
  
  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/health/liveness"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group" "eval_target" {
  name        = "${var.app_name}-eval-lb-tg"
  port        = var.eval_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
  
  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/health/liveness"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group" "da_target" {
  name        = "${var.app_name}-da-lb-tg"
  port        = var.da_port
  protocol    = "HTTP"
  vpc_id      = "${var.vpc_id}"
  target_type = "ip"
  
  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/api"
    unhealthy_threshold = "2"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Listener for the main load balancer
resource "aws_lb_listener" "main" {
  load_balancer_arn = aws_lb.main.id
  port              = "80"
  protocol          = "HTTP"
  #ssl_policy        = "ELBSecurityPolicy-2016-08"
  #certificate_arn   = data.aws_acm_certificate.cert.id

  default_action {
    target_group_arn = aws_lb_target_group.ui_target.id
    type             = "forward"
  }
}

# Forward requests to the target groups
resource "aws_lb_listener_rule" "ui" {
  listener_arn = aws_lb_listener.main.arn
  priority     = 99

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ui_target.arn
  }

  condition {
    host_header {
      values = ["app.${var.domain_name}"]
    }
  }
}

resource "aws_lb_listener_rule" "api" {
  listener_arn = aws_lb_listener.main.arn
  priority     = 95

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api_target.arn
  }

  condition {
    host_header {
      values = ["api.${var.domain_name}"]
    }
  }
}

resource "aws_lb_listener_rule" "eval" {
  listener_arn = aws_lb_listener.main.arn
  priority     = 91

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.eval_target.arn
  }

  condition {
    host_header {
      values = ["eval.${var.domain_name}"]
    }
  }
}

resource "aws_lb_listener_rule" "da" {
  listener_arn = aws_lb_listener.main.arn
  priority     = 87

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.da_target.arn
  }

  condition {
    host_header {
      values = ["da.${var.domain_name}"]
    }
  }
}