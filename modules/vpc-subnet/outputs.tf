output "cidr_block_by_availability_zone" {
  value = { for az in keys(var.subnet_number_by_availability_zone) : az => aws_subnet.subnet[az].cidr_block }
}

output "subnet_id_by_availability_zone" {
  value = { for az in keys(var.subnet_number_by_availability_zone) : az => aws_subnet.subnet[az].id }
}
