resource "aws_route_table_association" "route_table_association" {
  for_each       = var.route_table_id_by_availability_zone
  route_table_id = each.value
  subnet_id      = aws_subnet.subnet[each.key].id
}
