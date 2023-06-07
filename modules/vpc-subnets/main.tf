locals {
  net19_core     = cidrsubnet(var.vpc_cidr_block, 3, 0)
  net19_external = cidrsubnet(var.vpc_cidr_block, 3, 1)
  net19_internal = cidrsubnet(var.vpc_cidr_block, 3, 2)
  net19_unused_3 = cidrsubnet(var.vpc_cidr_block, 3, 3)
  net19_unused_4 = cidrsubnet(var.vpc_cidr_block, 3, 4)
  net19_unused_5 = cidrsubnet(var.vpc_cidr_block, 3, 5)
  net19_unused_6 = cidrsubnet(var.vpc_cidr_block, 3, 6)
  net19_unused_7 = cidrsubnet(var.vpc_cidr_block, 3, 7)

  net20_core_net = cidrsubnet(local.net19_core, 1, 0)
  net20_core_lb  = cidrsubnet(local.net19_core, 1, 1)

  # core net: routing and endpoints
  net22_core_net_direct   = cidrsubnet(local.net20_core_net, 2, 0)
  net22_core_net_private  = cidrsubnet(local.net20_core_net, 2, 1)
  net22_core_net_unused_2 = cidrsubnet(local.net20_core_net, 2, 2)
  net22_core_net_unused_3 = cidrsubnet(local.net20_core_net, 2, 3)

  # core lb: load balancers
  net21_core_lb_external = cidrsubnet(local.net20_core_lb, 1, 0)
  net21_core_lb_internal = cidrsubnet(local.net20_core_lb, 1, 1)

  # external
  net20_external_direct  = cidrsubnet(local.net19_external, 1, 0)
  net20_external_private = cidrsubnet(local.net19_external, 1, 1)
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr_block" {
  type = string
}

variable "subnet_number_by_availability_zone" {
  type = map(number)
}

variable "environment_name" {
  type = string
}

variable "direct_route_table_id_by_availability_zone" {
  type = map(string)
}
