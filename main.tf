terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "app_server" {
  ami                    = "ami-0b752bf1df193a6c4"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["sg-0e00978364e148d44"]
  subnet_id              = "subnet-0a777c7272fde2cf6"
  key_name               = "key-amazon"

  tags = {
    Name = "TerraformInstance"
    APP  = "hello-2048"
  }
}

