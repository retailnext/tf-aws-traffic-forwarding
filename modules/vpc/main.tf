locals {
  all_route_table_ids = toset([
    aws_route_table.direct.id,
  ])
}
