
resource "aws_subnet" "a" {yes

  vpc_id                  = aws_vpc.platform.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.name}-subnet-1"
  }
}
