resource "aws_launch_template" "server" {
  image_id      = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.server.id]

  credit_specification {
    cpu_credits = "standard"
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.name}-instance"
      nomad-instance-type = "server"
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

  user_data = templatefile("${path.module}/../config/nomad/server/config.yaml", {
    nomad_config = filebase64("${path.module}/../config/nomad/shared/nomad.hcl")
    systemd_service = filebase64("${path.module}/../config/nomad/server/nomad.service")
    server_config = filebase64("${path.module}/../config/nomad/server/server.hcl")
  })
}

// todo: add aws instance policyl
