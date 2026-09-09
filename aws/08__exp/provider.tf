// Configure the AWS provider required by this expressions example.
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }

  }
}

provider "aws" {
  region = "ap-south-1"
}

