resource "aws_subnet" "subnet" {
  for_each = var.subnet_number_by_availability_zone

  availability_zone               = each.key
  cidr_block                      = cidrsubnet(var.subnet_cidr_prefix, var.subnet_newbits, each.value)
  map_public_ip_on_launch         = var.map_public_ip_on_launch
  assign_ipv6_address_on_creation = var.assign_ipv6_address_on_creation
  vpc_id                          = var.vpc_id

  tags = {
    Name        = var.name
    Environment = var.environment_name
  }
}
