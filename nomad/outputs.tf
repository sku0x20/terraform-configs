output "server_public_ips" {
  value = aws_instance.server[*].public_ip
}

output "server_ipv6" {
  value = aws_instance.server[*].ipv6_addresses
}