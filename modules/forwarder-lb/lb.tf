resource "aws_lb" "lb" {
  name                             = "${var.name}-${var.environment_name}"
  internal                         = false
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = true

  tags = {
    Name        = var.name
    Environment = var.environment_name
  }

  dynamic "subnet_mapping" {
    for_each = var.eip_allocation_id_by_subnet_id
    content {
      subnet_id     = subnet_mapping.key
      allocation_id = subnet_mapping.value
    }
  }
}
