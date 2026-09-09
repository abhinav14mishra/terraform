// Define tags shared by the resources in this example.
locals {
  common_tags = {
    Environment = "prod"
    Project     = "vars"
    ManagedBy   = "terraform"
  }
}