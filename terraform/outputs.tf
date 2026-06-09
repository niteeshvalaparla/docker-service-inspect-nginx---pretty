output "node_a_public_ip" {
  value = aws_instance.node_a.public_ip
}

output "node_b_public_ip" {
  value = aws_instance.node_b.public_ip
}
