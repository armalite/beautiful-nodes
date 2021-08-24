output "instance" {
  value     = aws_instance.beautiful_node[*]
  sensitive = true
}