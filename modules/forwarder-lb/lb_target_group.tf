resource "aws_lb_target_group" "lb_target_group" {
  for_each = var.listener_by_id
  name     = "${var.name}-${each.key}-${var.environment_name}"
  protocol = each.value.protocol
  port     = each.value.instance_port
  vpc_id   = var.vpc_id

  tags = {
    Name        = "${var.name}-${each.key}-${var.environment_name}"
    Environment = var.environment_name
  }

  health_check {
    interval = 10
    path     = each.value.health_check_path
    protocol = each.value.health_check_protocol
    port     = each.value.health_check_port
  }
}
