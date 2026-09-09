// Create a VPC and the public subnets used by the instances.
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "MainVPC"
  }
}

resource "aws_subnet" "public" {
  count      = var.subnet_count
  vpc_id     = aws_vpc.main.id
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)

  tags = {
    Name = "Subnet-${count.index + 1}"
  }
}