resource "aws_vpc_dhcp_options" "dhcp_options" {
  domain_name_servers = [
    "AmazonProvidedDNS",
  ]

  ntp_servers = [
    "169.254.169.123",
  ]

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = var.environment_name
  }
}

resource "aws_vpc_dhcp_options_association" "dhcp_options_association" {
  dhcp_options_id = aws_vpc_dhcp_options.dhcp_options.id
  vpc_id          = aws_vpc.vpc.id
}
