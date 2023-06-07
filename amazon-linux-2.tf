data "aws_ami" "amazon-linux-2" {
  most_recent = true

  filter {
    name = "architecture"

    values = [
      "x86_64",
    ]
  }

  filter {
    name = "block-device-mapping.volume-type"

    values = [
      "gp2",
    ]
  }

  filter {
    name = "name"

    values = [
      "amzn2-ami-hvm-*",
    ]
  }

  filter {
    name = "virtualization-type"

    values = [
      "hvm",
    ]
  }

  owners = [
    "137112412989",
  ]
}
