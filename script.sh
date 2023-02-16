#!/bin/sh
amazon-linux-extras install -y docker
service docker start
systemctl enable docker
usermod -a -G docker ec2-user
pip3 install docker-compose
mkdir /home/ec2-user/hello-2048
cd /home/ec2-user/hello-2048
wget https://raw.githubusercontent.com/vozsiberiana/hello-2048/main/docker-compose>
chown ec2-user docker-compose.yml
docker-compose pull
docker-compose up -d
