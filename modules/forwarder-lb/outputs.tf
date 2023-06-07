output "target_group_arn_by_id" {
  value = { for id in keys(var.listener_by_id) : id => aws_lb_target_group.lb_target_group[id].arn }
}
