// Expose the instance ID as a sensitive output.
output "instance_id" {
  sensitive = true
  value = aws_instance.Linux_Instance.id
}