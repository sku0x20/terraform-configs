
resource "aws_instance" "server" {
  count = var.server_count

  ami                    = var.ami
  instance_type          = var.server_instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.server.id]
  credit_specification {
    cpu_credits = "standard"
  }
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.id
  tags = {
    Name                 = "${var.name}-server-${count.index}"
    consul-instance-type = "server"
  }

  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.server_root_block_device_size
    delete_on_termination = true
  }

  user_data = templatefile("${path.module}/configs/consul.yaml", {
    consul_config   = filebase64("${path.module}/configs/consul.hcl")
    systemd_service = filebase64("${path.module}/configs/consul.service")
    server_config   = filebase64("${path.module}/configs/server.hcl")
  })
}

