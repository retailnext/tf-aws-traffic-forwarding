resource "aws_default_network_acl" "default" {
  default_network_acl_id = aws_vpc.vpc.default_network_acl_id

  tags = {
    Name        = "default - DO NOT USE"
    Environment = var.environment_name
  }

  # https://www.terraform.io/docs/providers/aws/r/default_network_acl.html#managing-subnets-in-the-default-network-acl
  lifecycle {
    ignore_changes = [
      subnet_ids,
    ]
  }
}
