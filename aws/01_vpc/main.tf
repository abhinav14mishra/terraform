// Define a basic VPC and its core networking components.
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "sample_vpc" {
  cidr_block = "192.168.0.0/16"
  tags = {
    Name = "sample_vpc"
  }

}
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.sample_vpc.id
  cidr_block = "192.168.0.0/24"
}
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.sample_vpc.id
  cidr_block = "192.168.1.0/24"
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.sample_vpc.id
}
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.sample_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_subnet" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.rt.id
}
