module "subnets" {
  source = "../vpc-subnets"

  direct_route_table_id_by_availability_zone = local.direct_route_table_id_by_availability_zone
  environment_name                           = var.environment_name
  subnet_number_by_availability_zone         = var.subnet_number_by_availability_zone
  vpc_cidr_block                             = var.vpc_cidr_block
  vpc_id                                     = local.vpc_id
}
