module "core-lb-external" {
  source = "../vpc-subnet"

  environment_name                    = var.environment_name
  name                                = "core-lb-external"
  route_table_id_by_availability_zone = var.direct_route_table_id_by_availability_zone
  subnet_cidr_prefix                  = local.net21_core_lb_external
  subnet_newbits                      = 2
  subnet_number_by_availability_zone  = var.subnet_number_by_availability_zone
  vpc_id                              = var.vpc_id
}

output "core-lb-external" {
  value = module.core-lb-external
}
