// Declare and validate the inputs used to configure the instance.
variable "aws_region" {
  type    = string
  default = "ap-south-1"
}
variable "ec2_instance_type" {
  type        = string
  default     = "t3.small"
  description = "Instance type of an particular instance [t3.micro, t3.small, .....]"
  validation {
    condition     = var.ec2_instance_type == "t3.small" || var.ec2_instance_type == "t3.micro"
    error_message = "Supports only t3 series"
  }
}

# variable "ec2_volume_config" {
#   type = object({
#     size = number
#     type = string
#   })
#   default = {
#     size = 12
#     type = "gp3"
#   }
# }

variable "ec2_volume_config" {
  type = map(any)
  default = {
    size = 12
    type = "gp3"
  }
}
