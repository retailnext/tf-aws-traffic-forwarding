module "service-b-lb" {
  source = "./modules/forwarder-lb"

  alarm_action_arns           = local.alarm_action_arns
  alarm_max_active_flow_count = 10000
  alarm_min_active_flow_count = 0
  alarm_min_healthy_hosts     = 1
  environment_name            = local.environment_name
  name                        = "service-b"
  vpc_id                      = local.vpc_id

  eip_allocation_id_by_subnet_id = {
    (local.lb_subnet_id_by_availability_zone["us-east-1c"]) : aws_eip.service-b[0].id,
    (local.lb_subnet_id_by_availability_zone["us-east-1d"]) : aws_eip.service-b[1].id,
    (local.lb_subnet_id_by_availability_zone["us-east-1e"]) : aws_eip.service-b[2].id,
  }

  listener_by_id = {
    sftp = {
      protocol                 = "TCP"
      listener_certificate_arn = null
      listener_port            = 22
      listener_ssl_policy      = null
      instance_port            = local.forwarder_ports.service_b_sftp
      health_check_port        = local.forwarder_ports.health_check
      health_check_path        = "/"
      health_check_protocol    = "HTTP"
    }
  }
}

resource "aws_eip" "service-b" {
  count = 3
  vpc   = true

  tags = {
    Name = "service-b-${count.index + 1}"
  }

  lifecycle {
    prevent_destroy = true
  }
}
