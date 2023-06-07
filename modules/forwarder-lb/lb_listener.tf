resource "aws_lb_listener" "lb_listener" {
  for_each = var.listener_by_id

  certificate_arn   = each.value.listener_certificate_arn
  load_balancer_arn = aws_lb.lb.arn
  port              = each.value.listener_port
  protocol          = each.value.protocol
  ssl_policy        = each.value.listener_ssl_policy

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group[each.key].arn
  }
}
