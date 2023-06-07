locals {
  vpc_id                              = module.vpc.vpc_id
  lb_subnet_id_by_availability_zone   = module.vpc.subnets.core-lb-external.subnet_id_by_availability_zone
  lb_cidr_blocks_by_availability_zone = values(module.vpc.subnets.core-lb-external.cidr_block_by_availability_zone)
}

module "vpc" {
  source = "./modules/vpc"

  aws_region       = local.region
  environment_name = local.environment_name
  vpc_cidr_block   = "192.168.0.0/16"

  subnet_number_by_availability_zone = {
    "us-east-1c" : 0,
    "us-east-1d" : 1,
    "us-east-1e" : 2,
  }
}
