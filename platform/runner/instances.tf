
resource "aws_instance" "server" {
  count = 2

  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.instance.id]
  credit_specification {
    cpu_credits = "standard"
  }

  tags = {
    Name = "${var.name}-${count.index}"
  }

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 10
    delete_on_termination = true
  }
}
