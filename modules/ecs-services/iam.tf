# -------------------------------------------
# ECS / Task Execution Role
# -------------------------------------------
data "template_file" "ecs_task_assume_role" {
  template  = "${file("${path.module}/templates/assume_role.json.tpl")}"
  vars = {
    service = "ecs-tasks.amazonaws.com"
  }
}

data "template_file" "ecs_task_role" {
  template  = "${file("${path.module}/templates/ecs_task.json.tpl")}"
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "${var.app_name}-ecs-task-iam-role"
  assume_role_policy = "${data.template_file.ecs_task_assume_role.rendered}"
}

resource "aws_iam_role_policy" "ecs_task_execution_role_policy" {
  name       = "${var.app_name}-ecs-task-iam-policy"
  role       = "${aws_iam_role.ecs_task_execution_role.id}"
  policy     = "${data.template_file.ecs_task_role.rendered}"
}

# -------------------------------------------
# ECS / Task Auto-Scale Role
# -------------------------------------------

data "template_file" "ecs_task_auto_scale_assume_role" {
  template  = "${file("${path.module}/templates/assume_role.json.tpl")}"
  vars = {
    service = "application-autoscaling.amazonaws.com"
  }
}
data "template_file" "ecs_task_auto_scale_role" {
  template  = "${file("${path.module}/templates/ecs_autoscale.json.tpl")}"
}

resource "aws_iam_role" "ecs_auto_scale_role" {
  name               = "${var.app_name}-ecs-autoscale-iam-role"
  assume_role_policy = "${data.template_file.ecs_task_auto_scale_assume_role.rendered}"
}

resource "aws_iam_role_policy" "ecs_task_auto_scale_role_policy" {
  name       = "${var.app_name}-ecs-autoscale-iam-policy"
  role       = "${aws_iam_role.ecs_auto_scale_role.id}"
  policy     = "${data.template_file.ecs_task_auto_scale_role.rendered}"
}