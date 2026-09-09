// Demonstrate for-expressions over numbers and objects.
locals {
  double_numbers = [for i in var.number_list : i * 2]
}

output "double_numbers_output" {
  value = local.double_numbers
}

output "person_names_output" {
  value = [for p in var.person : [p.name, p.age]]
}

