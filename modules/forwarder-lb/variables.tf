variable "alarm_action_arns" {
  type = set(string)
}

variable "alarm_max_active_flow_count" {
  type = number
}

variable "alarm_min_active_flow_count" {
  type = number
}

variable "alarm_min_healthy_hosts" {
  type = number
}

variable "eip_allocation_id_by_subnet_id" {
  type = map(string)
}

variable "environment_name" {
  type = string
}

variable "listener_by_id" {
  type = map(object({
    protocol                 = string
    listener_certificate_arn = string
    listener_port            = number
    listener_ssl_policy      = string
    instance_port            = number
    health_check_port        = number
    health_check_path        = string
    health_check_protocol    = string
  }))
}

variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}
