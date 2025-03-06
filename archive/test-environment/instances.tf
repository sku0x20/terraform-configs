resource "aws_instance" "vm" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.vm.id]
  associate_public_ip_address = true
  credit_specification {
    cpu_credits = "standard"
  }

  tags = {
    name = "${var.name}-vm"
  }

  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.root_block_device_size
    delete_on_termination = true
  }

  user_data = data.cloudinit_config.my_cloud_config.rendered

}
