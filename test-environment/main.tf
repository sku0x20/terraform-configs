
terraform {
  required_version = ">=0.12"
}

provider "aws" {
  region = var.region
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "vm" {
  name   = "${var.name}-security-group"
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
}

