output "instance_ids" {
  value = aws_instance.instance[*].id
}
output "subnet_ids" {
  value = aws_subnet.public[*].id
}
