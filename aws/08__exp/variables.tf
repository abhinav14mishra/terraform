variable "number_list" {
  description = "A list of numbers"
  type        = list(number)
  default     = [1, 2, 3, 4, 5]
}

variable "person" {
  description = "A person object"
  type = list(object({
    name = string
    age  = number
  }))
}