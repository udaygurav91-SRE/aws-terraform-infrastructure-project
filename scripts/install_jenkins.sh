#!/bin/bash

sudo yum update -y
sudo yum install java-17-amazon-corretto -y

sudo wget -O /etc/yum.repos.d/jenkins.repo \
https://pkg.jenkins.io/redhat-stable/jenkins.repo

sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key

sudo yum install jenkins -y

sudo systemctl enable jenkins
sudo systemctl start jenkins
