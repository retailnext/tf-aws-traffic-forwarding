module "external-direct" {
  source = "../vpc-subnet"

  environment_name                    = var.environment_name
  map_public_ip_on_launch             = true
  name                                = "external-direct"
  route_table_id_by_availability_zone = var.direct_route_table_id_by_availability_zone
  subnet_cidr_prefix                  = local.net20_external_direct
  subnet_newbits                      = 2
  subnet_number_by_availability_zone  = var.subnet_number_by_availability_zone
  vpc_id                              = var.vpc_id
}

output "external-direct" {
  value = module.external-direct
}
