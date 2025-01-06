output "public_ips" {
  value = aws_instance.vm[*].public_ip
}

output "vm_ipv6" {
  value = aws_instance.vm[*].ipv6_addresses
}