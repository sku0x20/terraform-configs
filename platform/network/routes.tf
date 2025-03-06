

resource "aws_route_table" "nat" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "${var.name}-nat"
  }
}

resource "aws_route_table_association" "nat-with-a" {
  subnet_id      = aws_subnet.a.id
  route_table_id = aws_route_table.nat.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }

  tags = {
    Name = "${var.name}-public"
  }
}

resource "aws_route_table_association" "ig-with-public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
