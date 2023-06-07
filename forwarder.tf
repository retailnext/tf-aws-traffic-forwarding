locals {
  forwarder_ports = {
    service_a_http  = 61040
    service_a_https = 61204
    service_b_sftp  = 60978
    health_check    = 60946
  }

  target_addresses = {
    service_a = "172.16.0.1"
    service_b = "172.16.0.2"
  }

  target_ports = {
    service_a_http  = 80
    service_a_https = 443
    service_b_sftp  = 22
  }
}

module "forwarder" {
  source = "./modules/forwarder"

  ami_id                          = data.aws_ami.amazon-linux-2.image_id
  desired_capacity                = 3
  environment_name                = local.environment_name
  health_check_source_cidr_blocks = values(module.vpc.subnets.core-lb-external.cidr_block_by_availability_zone)
  instance_profile_id             = module.forwarder-role.instance_profile_id
  instance_type                   = "c5.large"
  max_size                        = 9
  min_size                        = 3
  name                            = "forwarder"
  subnet_ids                      = values(module.vpc.subnets.external-direct.subnet_id_by_availability_zone)
  vpc_id                          = module.vpc.vpc_id

  http_health_check_ports = [
    local.forwarder_ports.health_check,
  ]

  target_group_arns = setunion(
    values(module.service-a-lb.target_group_arn_by_id),
    values(module.service-b-lb.target_group_arn_by_id),
  )

  forwarding_rules = [
    {
      protocol   = "tcp"
      from_port  = local.forwarder_ports.service-a_https
      to_port    = local.target_ports.service-a_https
      to_address = local.target_addresses.service-a
    },
    {
      protocol   = "tcp"
      from_port  = local.forwarder_ports.service-b_device_http
      to_port    = local.target_ports.service-b_device_http
      to_address = local.target_addresses.service-b
    },
  ]
}
