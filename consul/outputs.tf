output "server_public_ips" {
  value = aws_instance.server[*].public_ip
}

output "server_ipv6_ips" {
  value = aws_instance.server[*].ipv6_addresses[*].public_ip
}

output "client_public_ips" {
  value = aws_instance.client[*].public_ip
}

output "client_ipv6_ips" {
  value = aws_instance.client[*].ipv6_addresses[*].public_ip
}
