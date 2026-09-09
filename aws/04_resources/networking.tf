// Build the VPC, subnets, gateway, and public route table.

resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"
  tags = merge(local.common_tags, {
    Name = "vpc"
  })
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
  tags = merge(local.common_tags, {
    Name = "public_subnet"
  })
}
resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.this.id
  cidr_block = "10.0.1.0/24"
  tags = merge(local.common_tags, {
    Name = "private_subnet"
  })
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id
  tags = merge(local.common_tags, {
    Name = "internet_gateway"
  })
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge(local.common_tags, {
    Name = "route_table"
  })

}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.route_table.id
}