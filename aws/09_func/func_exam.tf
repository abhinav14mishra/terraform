// Demonstrate Terraform string and numeric functions.
locals {
  name = "abhinav mishra"
  age = -23
}

output "name" {
  value = upper(local.name)
}

output "age" {
  value = abs(local.age)
}