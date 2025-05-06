# -------------------------------------------
# AWS AutoScaling Ressources Template
# -------------------------------------------

# -------------------------------------------
# ui
# -------------------------------------------

resource "aws_appautoscaling_target" "ui-target" {
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.ui.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  role_arn           = aws_iam_role.ecs_auto_scale_role.arn
  min_capacity       = 1
  max_capacity       = 8
}

# Scale UP policy 
resource "aws_appautoscaling_policy" "ui-up" {
  name               = "${var.app_name}-ui-up-autoscale"
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.ui.name}"
  scalable_dimension = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }
  depends_on = [aws_appautoscaling_target.ui-target]
}

# Scale DOWN policy
resource "aws_appautoscaling_policy" "ui-down" {
  name               = "${var.app_name}-ui-down-autoscale"
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.ui.name}"
  scalable_dimension = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = -1
    }
  }
  depends_on = [aws_appautoscaling_target.ui-target]
}

# -------------------------------------------
# api
# -------------------------------------------

resource "aws_appautoscaling_target" "api-target" {
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.api.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  role_arn           = aws_iam_role.ecs_auto_scale_role.arn
  min_capacity       = 1
  max_capacity       = 8
}

# Scale UP policy 
resource "aws_appautoscaling_policy" "api-up" {
  name               = "${var.app_name}-api-up-autoscale"
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.api.name}"
  scalable_dimension = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }
  depends_on = [aws_appautoscaling_target.api-target]
}

# Scale DOWN policy
resource "aws_appautoscaling_policy" "api-down" {
  name               = "${var.app_name}-api-down-autoscale"
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.api.name}"
  scalable_dimension = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = -1
    }
  }
  depends_on = [aws_appautoscaling_target.api-target]
}

# -------------------------------------------
# eval
# -------------------------------------------

resource "aws_appautoscaling_target" "eval-target" {
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.eval.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  role_arn           = aws_iam_role.ecs_auto_scale_role.arn
  min_capacity       = 1
  max_capacity       = 8
}

# Scale UP policy 
resource "aws_appautoscaling_policy" "eval-up" {
  name               = "${var.app_name}-eval-up-autoscale"
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.eval.name}"
  scalable_dimension = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }
  depends_on = [aws_appautoscaling_target.eval-target]
}

# Scale DOWN policy
resource "aws_appautoscaling_policy" "eval-down" {
  name               = "${var.app_name}-eval-down-autoscale"
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.eval.name}"
  scalable_dimension = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = -1
    }
  }
  depends_on = [aws_appautoscaling_target.eval-target]
}

# -------------------------------------------
# da
# -------------------------------------------

resource "aws_appautoscaling_target" "da-target" {
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.da.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  role_arn           = aws_iam_role.ecs_auto_scale_role.arn
  min_capacity       = 1
  max_capacity       = 8
}

# Scale UP policy 
resource "aws_appautoscaling_policy" "da-up" {
  name               = "${var.app_name}-da-up-autoscale"
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.da.name}"
  scalable_dimension = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }
  depends_on = [aws_appautoscaling_target.da-target]
}

# Scale DOWN policy
resource "aws_appautoscaling_policy" "da-down" {
  name               = "${var.app_name}-da-down-autoscale"
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.da.name}"
  scalable_dimension = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = -1
    }
  }
  depends_on = [aws_appautoscaling_target.da-target]
}

# -------------------------------------------
# CloudWatch  Ressources Template
# Set up CloudWatch group a log stream and retain logs
# -------------------------------------------

# -------------------------------------------
# Custom cloudwatch alarm 
# -------------------------------------------

resource "aws_sns_topic" "error-topic" {
  name = "${var.app_name}-error-topic"
}

resource "aws_sns_topic_subscription" "email-target-jy" {
  topic_arn = aws_sns_topic.error-topic.arn
  protocol  = "email"
  endpoint  = "ijiyun.yang@gmail.com"
}

# -------------------------------------------
# UI
# -------------------------------------------

resource "aws_cloudwatch_log_group" "cw_log_group_ui" {
  name              = "/ecs/${var.app_name}-ui-log-group"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_stream" "cw_log_stream_ui" {
  name           = "${var.app_name}-ui-log-stream"
  log_group_name = "${aws_cloudwatch_log_group.cw_log_group_ui.name}"
}

# create cloudwatch metric filters
resource "aws_cloudwatch_log_metric_filter" "error-ui-metric-filter" {
  name           = "${var.app_name}-ui-error-count"
  log_group_name = "${aws_cloudwatch_log_group.cw_log_group_ui.name}"
  pattern        = "fail"
  metric_transformation {
    name      = "${var.app_name}-ui-error-metric"
    namespace = "${var.app_name}-ui"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "error-ui-alarm" {
  alarm_name          = "${var.app_name}-ui-error-alarm"
  metric_name         = aws_cloudwatch_log_metric_filter.error-ui-metric-filter.metric_transformation[0].name
  threshold           = "0"
  statistic           = "Sum"
  comparison_operator = "GreaterThanThreshold"
  datapoints_to_alarm = "1"
  evaluation_periods  = "1"
  period              = "60"
  namespace           = "${var.app_name}-ui"
  alarm_actions       = [aws_sns_topic.error-topic.arn]
  treat_missing_data  = "notBreaching"
}

# CloudWatch alarm to trigger the autoscaling UP policy
resource "aws_cloudwatch_metric_alarm" "ui_service_cpu_high" {
  alarm_name          = "${var.app_name}-ui-cpu-utilization-high-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "85"

  dimensions = {
    ClusterName = "${aws_ecs_cluster.main.name}"
    ServiceName = "${aws_ecs_service.ui.name}"
  }

  alarm_actions = ["${aws_appautoscaling_policy.ui-up.arn}"]
}

# CloudWatch alarm to trigger the autoscaling DOWN policy
resource "aws_cloudwatch_metric_alarm" "ui_service_cpu_low" {
  alarm_name          = "${var.app_name}-ui-cpu-utilization-low-alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "10"

  dimensions = {
    ClusterName = "${aws_ecs_cluster.main.name}"
    ServiceName = "${aws_ecs_service.ui.name}"
  }

  alarm_actions = ["${aws_appautoscaling_policy.ui-down.arn}"]
}

# -------------------------------------------
# api
# -------------------------------------------

resource "aws_cloudwatch_log_group" "cw_log_group_api" {
  name              = "/ecs/${var.app_name}-api-log-group"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_stream" "cw_log_stream_api" {
  name           = "${var.app_name}-api-log-stream"
  log_group_name = "${aws_cloudwatch_log_group.cw_log_group_api.name}"
}

# create cloudwatch metric filters
resource "aws_cloudwatch_log_metric_filter" "error-api-metric-filter" {
  name           = "${var.app_name}-api-error-count"
  log_group_name = "${aws_cloudwatch_log_group.cw_log_group_api.name}"
  pattern        = "fail"
  metric_transformation {
    name      = "${var.app_name}-api-error-metric"
    namespace = "${var.app_name}-api"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "error-api-alarm" {
  alarm_name          = "${var.app_name}-api-error-alarm"
  metric_name         = aws_cloudwatch_log_metric_filter.error-api-metric-filter.metric_transformation[0].name
  threshold           = "0"
  statistic           = "Sum"
  comparison_operator = "GreaterThanThreshold"
  datapoints_to_alarm = "1"
  evaluation_periods  = "1"
  period              = "60"
  namespace           = "${var.app_name}-api"
  alarm_actions       = [aws_sns_topic.error-topic.arn]
  treat_missing_data  = "notBreaching"
}

# CloudWatch alarm to trigger the autoscaling UP policy
resource "aws_cloudwatch_metric_alarm" "api_service_cpu_high" {
  alarm_name          = "${var.app_name}-api-cpu-utilization-high-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "85"

  dimensions = {
    ClusterName = "${aws_ecs_cluster.main.name}"
    ServiceName = "${aws_ecs_service.api.name}"
  }

  alarm_actions = ["${aws_appautoscaling_policy.api-up.arn}"]
}

# CloudWatch alarm to trigger the autoscaling DOWN policy
resource "aws_cloudwatch_metric_alarm" "api_service_cpu_low" {
  alarm_name          = "${var.app_name}-api-cpu-utilization-low-alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"


  statistic           = "Average"
  threshold           = "10"

  dimensions = {
    ClusterName = "${aws_ecs_cluster.main.name}"
    ServiceName = "${aws_ecs_service.api.name}"
  }

  alarm_actions = ["${aws_appautoscaling_policy.api-down.arn}"]
}

# -------------------------------------------
# eval
# -------------------------------------------

resource "aws_cloudwatch_log_group" "cw_log_group_eval" {
  name              = "/ecs/${var.app_name}-eval-log-group"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_stream" "cw_log_stream_eval" {
  name           = "${var.app_name}-eval-log-stream"
  log_group_name = "${aws_cloudwatch_log_group.cw_log_group_eval.name}"
}

# create cloudwatch metric filters
resource "aws_cloudwatch_log_metric_filter" "error-eval-metric-filter" {
  name           = "${var.app_name}-eval-error-count"
  log_group_name = "${aws_cloudwatch_log_group.cw_log_group_eval.name}"
  pattern        = "fail"
  metric_transformation {
    name      = "${var.app_name}-eval-error-metric"
    namespace = "${var.app_name}-eval"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "error-eval-alarm" {
  alarm_name          = "${var.app_name}-eval-error-alarm"
  metric_name         = aws_cloudwatch_log_metric_filter.error-eval-metric-filter.metric_transformation[0].name
  threshold           = "0"
  statistic           = "Sum"
  comparison_operator = "GreaterThanThreshold"
  datapoints_to_alarm = "1"
  evaluation_periods  = "1"
  period              = "60"
  namespace           = "${var.app_name}-eval"
  alarm_actions       = [aws_sns_topic.error-topic.arn]
  treat_missing_data  = "notBreaching"
}

# CloudWatch alarm to trigger the autoscaling UP policy
resource "aws_cloudwatch_metric_alarm" "eval_service_cpu_high" {
  alarm_name          = "${var.app_name}-eval-cpu-utilization-high-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "85"

  dimensions = {
    ClusterName = "${aws_ecs_cluster.main.name}"
    ServiceName = "${aws_ecs_service.eval.name}"
  }

  alarm_actions = ["${aws_appautoscaling_policy.eval-up.arn}"]
}

# CloudWatch alarm to trigger the autoscaling DOWN policy
resource "aws_cloudwatch_metric_alarm" "eval_service_cpu_low" {
  alarm_name          = "${var.app_name}-eval-cpu-utilization-low-alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "10"

  dimensions = {
    ClusterName = "${aws_ecs_cluster.main.name}"
    ServiceName = "${aws_ecs_service.eval.name}"
  }

  alarm_actions = ["${aws_appautoscaling_policy.eval-down.arn}"]
}

# -------------------------------------------
# da
# -------------------------------------------

resource "aws_cloudwatch_log_group" "cw_log_group_da" {
  name              = "/ecs/${var.app_name}-da-log-group"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_stream" "cw_log_stream_da" {
  name           = "${var.app_name}-da-log-stream"
  log_group_name = "${aws_cloudwatch_log_group.cw_log_group_da.name}"
}

# create cloudwatch metric filters
resource "aws_cloudwatch_log_metric_filter" "error-da-metric-filter" {
  name           = "${var.app_name}-da-error-count"
  log_group_name = "${aws_cloudwatch_log_group.cw_log_group_da.name}"
  pattern        = "fail"
  metric_transformation {
    name      = "${var.app_name}-da-error-metric"
    namespace = "${var.app_name}-da"
    value     = "1"
  }
}

resource "aws_cloudwatch_metric_alarm" "error-da-alarm" {
  alarm_name          = "${var.app_name}-da-error-alarm"
  metric_name         = aws_cloudwatch_log_metric_filter.error-da-metric-filter.metric_transformation[0].name
  threshold           = "0"
  statistic           = "Sum"
  comparison_operator = "GreaterThanThreshold"
  datapoints_to_alarm = "1"
  evaluation_periods  = "1"
  period              = "60"
  namespace           = "${var.app_name}-da"
  alarm_actions       = [aws_sns_topic.error-topic.arn]
  treat_missing_data  = "notBreaching"
}

# CloudWatch alarm to trigger the autoscaling UP policy
resource "aws_cloudwatch_metric_alarm" "da_service_cpu_high" {
  alarm_name          = "${var.app_name}-da-cpu-utilization-high-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "85"

  dimensions = {
    ClusterName = "${aws_ecs_cluster.main.name}"
    ServiceName = "${aws_ecs_service.da.name}"
  }

  alarm_actions = ["${aws_appautoscaling_policy.da-up.arn}"]
}

# CloudWatch alarm to trigger the autoscaling DOWN policy
resource "aws_cloudwatch_metric_alarm" "da_service_cpu_low" {
  alarm_name          = "${var.app_name}-da-cpu-utilization-low-alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "60"
  statistic           = "Average"
  threshold           = "10"

  dimensions = {
    ClusterName = "${aws_ecs_cluster.main.name}"
    ServiceName = "${aws_ecs_service.da.name}"
  }

  alarm_actions = ["${aws_appautoscaling_policy.da-down.arn}"]
}
