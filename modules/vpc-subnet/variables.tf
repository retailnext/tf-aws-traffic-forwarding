variable "assign_ipv6_address_on_creation" {
  type    = bool
  default = false
}

variable "environment_name" {
  type = string
}

variable "map_public_ip_on_launch" {
  type    = bool
  default = false
}

variable "name" {
  type = string
}

variable "route_table_id_by_availability_zone" {
  type = map(string)
}

variable "subnet_cidr_prefix" {
  type = string
}

variable "subnet_newbits" {
  type = number
}

variable "subnet_number_by_availability_zone" {
  type = map(number)
}

variable "vpc_id" {
  type = string
}
