

resource "aws_ec2_instance_connect_endpoint" "connect_endpoint" {
  subnet_id = aws_subnet.a.id
}

