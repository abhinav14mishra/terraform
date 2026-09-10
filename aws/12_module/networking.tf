data "aws_availability_zones" "azs" {
  state = "available"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "my_vpc"

  cidr            = "10.0.0.0/16"
  azs             = data.aws_availability_zones.azs.name
  private_subnets = ["10.0.0.0/16"]
  public_subnets  = ["10.0.128.0/16"]
}

provider "aws" {
  region = "ap-south-1"
}