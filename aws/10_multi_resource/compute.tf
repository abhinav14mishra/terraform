locals {
  ami_ids = {
    ubuntu = data.aws_ami.ubuntu.id
    amazon = data.aws_ami.amzn.id
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "name"
    # Ubuntu 22.04 LTS (Jammy)
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]

    # Or for Ubuntu 24.04 LTS (Noble):
    # values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical's official AWS account ID
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

resource "aws_instance" "instance" {

  count = length(var.ec2_instance_config)

  ami           = local.ami_ids[var.ec2_instance_config[count.index].ami]
  instance_type = var.ec2_instance_config[count.index].type
  subnet_id     = aws_subnet.public[count.index % length(aws_subnet.public)].id


  tags = {
    Name = "Instance-${count.index + 1}"
  }
}