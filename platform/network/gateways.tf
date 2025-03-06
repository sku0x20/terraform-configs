
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.name}-ig"
  }
}

resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name = "${var.name}"
  }
}

resource "aws_nat_gateway" "nat" {
  subnet_id         = aws_subnet.a.id
  connectivity_type = "public"
  allocation_id     = aws_eip.nat_eip.id

  tags = {
    Name = "${var.name}-nat"
  }

  depends_on = [aws_internet_gateway.ig]
}
