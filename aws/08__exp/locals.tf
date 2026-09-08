locals {
  math       = 2 + 2
  equality   = 2 != 2
  comparison = 2 > 1
  logical    = true && false
}

output "operator_output" {
  value = {
    math       = local.math
    equality   = local.equality
    comparison = local.comparison
    logical    = local.logical
  }
}