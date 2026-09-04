
resource "aws_instance" "web" {
  ami           = "ami-090d68841c2a28756"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  root_block_device {
    volume_size = 8
    volume_type = "gp3"
  }
  user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y nginx
              systemctl start nginx
              systemctl enable nginx
              echo "<h1>Deployed on Amazon Linux 2023 via Terraform</h1>" > /usr/share/nginx/html/index.html
              EOF
  tags = merge(local.common_tags, {
    Name = "web_instance"
  })
  lifecycle {
    create_before_destroy = true
  }
}

output "web_instance_public_ip" {
  value = aws_instance.web.public_ip
}