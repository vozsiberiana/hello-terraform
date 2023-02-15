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
    Name = var.instance_name
    APP  = "hello-2048"
  }
  user_data = <<EOH
#!/bin/sh
amazon-linux-extras install -y docker
service docker start
systemctl enable docker
usermod -a -G docker ec2-user
pip3 install docker-compose
mkdir /home/ec2-user/hello-2048
cd /home/ec2-user/hello-2048
wget https://raw.githubusercontent.com/vozsiberiana/hello-2048/main/docker-compose.yml
chown ec2-user docker-compose.yml
docker-compose pull
docker-compose up -d
EOH

}
