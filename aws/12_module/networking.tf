locals {
  vpc_cidr              = "10.0.0.0/16"
  azs                   = data.aws_availability_zones.azs.names
  private_subnets_cidrs = ["10.0.0.0/24"]
  public_subnets_cidrs  = ["10.0.128.0/24"]
}

data "aws_availability_zones" "azs" {
  state = "available"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "my_vpc"

  cidr            = local.vpc_cidr
  azs             = data.aws_availability_zones.azs.names
  private_subnets = local.public_subnets_cidrs
  public_subnets  = local.private_subnets_cidrs

  tags = local.common_tags
}

provider "aws" {
  region = "ap-south-1"
}