locals {
  allowed_instance_types = ["t3.micro", "t3.small"]
}
data "aws_ami" "amzn" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-kernel-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}
resource "aws_instance" "amzn_instance" {
  ami           = data.aws_ami.amzn.id
  instance_type = var.instance_type
  subnet_id = aws_subnet.this.id
  lifecycle {
    precondition {
      condition = contains(local.allowed_instance_types, var.instance_type)
      error_message = "Only t3.micro & t3.small is allowed"
    }
    postcondition {
      condition = contains(local.allowed_instance_types, self.instance_type)
      error_message = "Only t3.micro & t3.small is allowed"
    }
  }
}