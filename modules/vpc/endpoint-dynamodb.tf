resource "aws_vpc_endpoint" "dynamodb" {
  service_name    = "com.amazonaws.${var.aws_region}.dynamodb"
  vpc_id          = local.vpc_id
  route_table_ids = local.all_route_table_ids
}
