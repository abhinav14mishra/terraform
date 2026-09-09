// Declare and validate subnet and instance configuration inputs.
variable "subnet_count" {
  type    = number
  default = 1
  validation {
    condition     = var.subnet_count > 0
    error_message = "The subnet_count variable must be greater than 0."
  }
}

variable "ec2_instance_config" {
  type = list(object({
    type = string
    ami  = string
  }))

  validation {
    condition     = length(var.ec2_instance_config) > 0
    error_message = "The ec2_instance_config variable must contain at least one instance configuration."
  }
  validation {
    condition     = alltrue([for instance in var.ec2_instance_config : contains(["t3.micro", "t3.small"], instance.type)])
    error_message = "The ec2_instance_config variable contains an invalid instance type. Allowed types are: t3.micro, t3.small."
  }
  validation {
    condition     = alltrue([for instance in var.ec2_instance_config : contains(["ubuntu", "amazon"], instance.ami)])
    error_message = "The ec2_instance_config variable contains an invalid AMI type. Allowed types are: ubuntu, amazon."
  }
}