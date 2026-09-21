data "aws_key_pair" "day12" {
  key_name = var.key_name
}

data "aws_subnet" "public" {
  id = var.public_subnet_id
}

data "aws_vpc" "main" {
  id = data.aws_subnet.public.vpc_id
}

data "aws_ssm_parameter" "al2023_ami" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}
