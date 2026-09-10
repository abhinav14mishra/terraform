// Return IDs for the instances and subnets created by this example.
output "instance_ids" {
  value = [for instance in aws_instance.from_map : instance.id]
}
output "subnet_ids" {
  value = aws_subnet.public[*].id
}
