
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  subnet_id         = aws_subnet.a.id
  connectivity_type = "public"
  allocation_id     = aws_eip.nat_eip.id

  tags = {
    Name = "${var.name}-nat"
  }
}
