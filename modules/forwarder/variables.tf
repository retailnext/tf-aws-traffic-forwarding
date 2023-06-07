variable "ami_id" {
  type = string
}

variable "associate_public_ip_address" {
  type    = bool
  default = true
}

variable "desired_capacity" {
  type = number
}

variable "environment_name" {
  type = string
}

variable "forwarding_rules" {
  type = list(object({
    from_port  = number
    protocol   = string
    to_address = string
    to_port    = number
  }))
}

variable "health_check_source_cidr_blocks" {
  type = set(string)
}

variable "http_health_check_ports" {
  type = set(number)
}

variable "instance_profile_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "max_size" {
  type = number
}

variable "min_size" {
  type = number
}

variable "name" {
  type = string
}

variable "subnet_ids" {
  type = set(string)
}

variable "target_group_arns" {
  type = set(string)
}

variable "vpc_id" {
  type = string
}
