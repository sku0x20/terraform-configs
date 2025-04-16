resource "aws_launch_template" "client" {
  image_id      = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.client.id]

  iam_instance_profile {
    arn = aws_iam_instance_profile.client.arn
  }

  credit_specification {
    cpu_credits = "standard"
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.name}-instance"
      nomad-instance-type = "client"
    }
  }

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_type = "gp3"
      volume_size = var.root_block_size
    }
  }

  tags = {
    Name = "${var.name}-template"
  }

  user_data = base64encode(templatefile("${path.module}/../config/nomad/client/config.yaml", {
    nomad_config = filebase64("${path.module}/../config/nomad/shared/nomad.hcl")
    systemd_service = filebase64("${path.module}/../config/nomad/client/nomad.service")
    client_config = filebase64("${path.module}/../config/nomad/client/client.hcl")
  }))
}
