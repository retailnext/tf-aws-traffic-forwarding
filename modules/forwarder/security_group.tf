resource "aws_security_group" "security_group" {
  name   = var.name
  vpc_id = var.vpc_id

  tags = {
    Name        = var.name
    Environment = var.environment_name
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  ingress {
    from_port       = -1
    to_port         = -1
    protocol        = "icmp"
    self            = false
    security_groups = []
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  dynamic "ingress" {
    for_each = var.http_health_check_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = var.health_check_source_cidr_blocks
    }
  }

  dynamic "ingress" {
    for_each = var.forwarding_rules
    content {
      from_port = ingress.value.from_port
      to_port   = ingress.value.from_port
      protocol  = ingress.value.protocol
      cidr_blocks = [
        "0.0.0.0/0",
      ]
    }
  }
}
