resource "aws_cloudwatch_metric_alarm" "active_flow_count_high" {
  count = var.alarm_max_active_flow_count > 0 ? 1 : 0

  alarm_name          = "ActiveFlowCount High ${var.name}-${var.environment_name}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "ActiveFlowCount"
  namespace           = "AWS/NetworkELB"
  period              = 60
  statistic           = "Average"
  threshold           = var.alarm_max_active_flow_count
  treat_missing_data  = "missing"

  dimensions = {
    LoadBalancer = aws_lb.lb.arn_suffix
  }

  alarm_description = "Trigger an alert when ${var.name}-${var.environment_name} has >= ${var.alarm_max_active_flow_count} active flows"

  alarm_actions = var.alarm_action_arns

  ok_actions = var.alarm_action_arns
}

resource "aws_cloudwatch_metric_alarm" "active_flow_count_low" {
  count = var.alarm_min_active_flow_count > 0 ? 1 : 0

  alarm_name          = "ActiveFlowCount Low ${var.name}-${var.environment_name}"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "ActiveFlowCount"
  namespace           = "AWS/NetworkELB"
  period              = 60
  statistic           = "Average"
  threshold           = var.alarm_min_active_flow_count
  treat_missing_data  = "missing"

  dimensions = {
    LoadBalancer = aws_lb.lb.arn_suffix
  }

  alarm_description = "Trigger an alert when ${var.name}-${var.environment_name} has >= ${var.alarm_min_active_flow_count} active flows"

  alarm_actions = var.alarm_action_arns

  ok_actions = var.alarm_action_arns
}

resource "aws_cloudwatch_metric_alarm" "healthy_host_count_low" {
  for_each = var.alarm_min_healthy_hosts > 0 ? aws_lb_target_group.lb_target_group : {}

  alarm_name          = "HealthyHostCount Low ${each.value.name}"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "HealthyHostCount"
  namespace           = "AWS/NetworkELB"
  period              = 60
  statistic           = "Average"
  threshold           = var.alarm_min_healthy_hosts
  treat_missing_data  = "missing"

  dimensions = {
    LoadBalancer = aws_lb.lb.arn_suffix
    TargetGroup  = each.value.arn_suffix
  }

  alarm_description = "Trigger an alert when ${each.value.name} has <= ${var.alarm_min_healthy_hosts} healthy hosts"

  alarm_actions = var.alarm_action_arns

  ok_actions = var.alarm_action_arns
}
