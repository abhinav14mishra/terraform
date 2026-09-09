// Configure the AWS provider from the aws_region variable.
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }

  }
}

provider "aws" {
  region = var.aws_region
}

