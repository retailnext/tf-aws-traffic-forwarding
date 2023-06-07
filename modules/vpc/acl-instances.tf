resource "aws_network_acl" "instances" {
  vpc_id = local.vpc_id

  subnet_ids = setunion(
    values(module.subnets.external-direct.subnet_id_by_availability_zone),
  )

  tags = {
    Name        = "instances"
    Environment = var.environment_name
  }

  ingress {
    rule_no    = 100
    action     = "deny"
    protocol   = "tcp"
    from_port  = 22
    to_port    = 22
    cidr_block = "0.0.0.0/0"
  }

  ingress {
    rule_no    = 30000
    action     = "allow"
    protocol   = "-1"
    from_port  = 0
    to_port    = 0
    cidr_block = "0.0.0.0/0"
  }

  egress {
    rule_no    = 30000
    action     = "allow"
    protocol   = "-1"
    from_port  = 0
    to_port    = 0
    cidr_block = "0.0.0.0/0"
  }
}
