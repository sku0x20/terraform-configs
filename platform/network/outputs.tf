output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "subnet_a" {
  value = aws_subnet.a.id
}
output "subnet_public" {
  value = aws_subnet.public 
}
