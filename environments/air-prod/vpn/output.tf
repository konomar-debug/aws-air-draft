output "vpn1_peer_ip" {
  value       = aws_vpn_connection.vpn_connection.tunnel1_address
  description = "Public IP of tunnel 1"
}

output "vpn2_peer_ip" {
  value       = aws_vpn_connection.vpn_connection.tunnel2_address
  description = "Public IP of tunnel 2"
}
