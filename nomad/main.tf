
terraform {
  required_version = ">=0.12"
}

provider "aws" {
  region = var.region
}

data "aws_vpc" "default" {
  default = true
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

data "aws_iam_policy_document" "nomad_role_policy_doc" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:DescribeInstances"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "nomad_role_policy" {
  name   = "${var.name}-nomad-role-policy"
  policy = data.aws_iam_policy_document.nomad_role_policy_doc.json
}

data "aws_iam_policy_document" "nomad_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "nomad_role" {
  name                 = "${var.name}-nomad-role"
  assume_role_policy   = data.aws_iam_policy_document.nomad_assume_role.json
  permissions_boundary = aws_iam_policy.nomad_role_policy.id
}

resource "aws_iam_instance_profile" "nomad_instance_profile" {
  name = "${var.name}-nomad-instance-profile"
  role = aws_iam_role.nomad_role.id
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

  iam_instance_profile = aws_iam_instance_profile.nomad_instance_profile.id
  tags = {
    name                = "${var.name}-server-${count.index}"
    nomad-instance-type = "server"
  }

  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.root_block_device_size
    delete_on_termination = true
  }

  user_data = file("./scripts/init.sh")
}

