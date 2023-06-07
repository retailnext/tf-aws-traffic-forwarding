resource "aws_default_route_table" "default_route_table" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  tags = {
    Name        = "default - DO NOT USE"
    Environment = var.environment_name
  }
}
