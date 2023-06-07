resource "aws_vpc_endpoint" "s3" {
  service_name    = "com.amazonaws.${var.aws_region}.s3"
  vpc_id          = local.vpc_id
  route_table_ids = local.all_route_table_ids
}
