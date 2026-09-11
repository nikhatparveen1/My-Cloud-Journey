terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "ap-south-2"
}

resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "day-19-custom-vpc"
  }
}

resource "aws_subnet" "public_sub" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "day-19-public-subnet"
  }
}

resource "aws_subnet" "private_sub" {
  vpc_id     = aws_vpc.main_vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "day-19-private-subnet"
  }
}
