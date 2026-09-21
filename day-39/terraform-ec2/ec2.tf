resource "aws_instance" "docker_ec2" {
  ami                    = data.aws_ssm_parameter.al2023_ami.value
  instance_type          = "t3.micro"
  subnet_id              = data.aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.docker_ec2_sg.id]
  key_name               = data.aws_key_pair.day12.key_name

  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y docker
              systemctl enable --now docker
              usermod -aG docker ec2-user

              docker pull nikhatparveen1/my-cloud-journey:day38

              docker run -d \
                --name my-cloud-journey \
                -p 5000:5000 \
                nikhatparveen1/my-cloud-journey:day38
              EOF

  tags = {
    Name = "day-39-docker-ec2"
  }
}
