// Select the latest Amazon Linux AMI and create the instance.
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

  owners = ["amazon"] # Canonical
}

resource "aws_instance" "Linux_Instance" {
  ami           = data.aws_ami.amzn.id
  instance_type = var.ec2_instance_type
  root_block_device {
    delete_on_termination = true
    volume_size           = var.ec2_volume_config.size
    volume_type           = var.ec2_volume_config.type
  }

  tags = merge(local.common_tags, {
    Name = "Linux_Instance"
  })

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [ami]
  }
}
