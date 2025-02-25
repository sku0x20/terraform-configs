
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
    name                 = "${var.name}-server-${count.index}"
    consul-instance-type = "server"
  }

  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.server_root_block_device_size
    delete_on_termination = true
  }

  user_data = file("./scipts/server/init.sh")
}

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
    name                 = "${var.name}-client-${count.index}"
    consul-instance-type = "client"
  }

  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.client_root_block_device_size
    delete_on_termination = true
  }

  user_data = file("./scripts/client/init.sh")
}

// public ipv4 enabled subnet;
// amazonaws.com not ipv6 enabled; nat gateway unnecessary cost 
// cannot figure out how to add public ipv4 for vm when launching
