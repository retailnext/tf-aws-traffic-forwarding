locals {
  direct_route_table_id_by_availability_zone = { for az in keys(var.subnet_number_by_availability_zone) : az => aws_route_table.direct.id }
}

resource "aws_route" "direct-default" {
  route_table_id         = aws_route_table.direct.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}

resource "aws_route_table" "direct" {
  propagating_vgws = var.vpn_gateway_ids
  vpc_id           = aws_vpc.vpc.id

  tags = {
    Name        = "direct"
    Environment = var.environment_name
  }
}
