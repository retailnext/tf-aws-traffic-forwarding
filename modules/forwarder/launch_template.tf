resource "aws_launch_template" "launch_template" {
  name                                 = var.name
  instance_type                        = var.instance_type
  image_id                             = var.ami_id
  update_default_version               = true
  instance_initiated_shutdown_behavior = "terminate"
  user_data                            = data.cloudinit_config.cloudinit_config.rendered

  tags = {
    Name = var.name
  }

  iam_instance_profile {
    name = var.instance_profile_id
  }

  network_interfaces {
    associate_public_ip_address = var.associate_public_ip_address

    security_groups = [
      aws_security_group.security_group.id,
    ]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Environment = var.environment_name
      Name        = var.name
    }
  }

  tag_specifications {
    resource_type = "volume"
    tags = {
      Environment = var.environment_name
      Name        = var.name
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
