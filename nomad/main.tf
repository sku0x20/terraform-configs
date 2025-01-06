
terraform {
  required_version = ">=0.12"
}

provider "aws" {
  region = var.region
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "default" {
  
}

resource "aws_security_group" "server" {
  name   = "${var.name}-server-security-group"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}

resource "aws_instance" "server" {
  ami                         = var.ami
  instance_type               = var.server_instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.server.id]
  count                       = var.server_count
  associate_public_ip_address = true
  credit_specification {
    cpu_credits = "standard"
  }

  tags = {
    name = "${var.name}-server-${count.index}"
  }

  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.root_block_device_size
    delete_on_termination = true
  }

  user_data = file("./scripts/init.sh")
}

