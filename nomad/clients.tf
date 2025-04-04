
resource "aws_instance" "client" {
  count = var.client_count

  ami                    = var.ami
  instance_type          = var.client_instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.client.id]
  credit_specification {
    cpu_credits = "standard"
  }
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.id
  tags = {
    Name                = "${var.name}-client-${count.index}"
    nomad-instance-type = "client"
  }

  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.client_root_block_device_size
    delete_on_termination = true
  }

  user_data = templatefile("${path.module}/configs/client/client.yaml", {
    nomad_config    = filebase64("${path.module}/configs/shared/nomad.hcl")
    systemd_service = filebase64("${path.module}/configs/client/nomad.service")
    client_config   = filebase64("${path.module}/configs/client/client.hcl")
  })
}
