variable "aws_region" {
  type = string
}

variable "environment_name" {
  type = string
}

variable "subnet_number_by_availability_zone" {
  type = map(number)
}

variable "vpc_cidr_block" {
  type = string
}

variable "vpn_gateway_ids" {
  type    = set(string)
  default = []
}
