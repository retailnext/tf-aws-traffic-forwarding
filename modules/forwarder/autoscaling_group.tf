resource "aws_autoscaling_group" "autoscaling_group" {
  name                = var.name
  max_size            = var.max_size
  desired_capacity    = var.desired_capacity
  min_size            = var.min_size
  health_check_type   = "ELB"
  vpc_zone_identifier = var.subnet_ids
  target_group_arns   = var.target_group_arns

  enabled_metrics = [
    "GroupDesiredCapacity",
    "GroupInServiceCapacity",
    "GroupInServiceInstances",
    "GroupMaxSize",
    "GroupMinSize",
    "GroupPendingCapacity",
    "GroupPendingInstances",
    "GroupStandbyCapacity",
    "GroupStandbyInstances",
    "GroupTerminatingCapacity",
    "GroupTerminatingInstances",
    "GroupTotalCapacity",
    "GroupTotalInstances",
  ]

  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = var.name
  }

  tag {
    key                 = "Environment"
    propagate_at_launch = true
    value               = var.environment_name
  }

  launch_template {
    name    = aws_launch_template.launch_template.name
    version = aws_launch_template.launch_template.latest_version
  }
}
