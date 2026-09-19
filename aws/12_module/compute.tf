locals {
  instanec_type = "t3.micro"
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

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  name = "${local.common_tags.Project}-Instance"
  ami = data.aws_ami.amzn.id
  instance_type = local.instanec_type
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id = module.vpc.public_subnets[0]
}