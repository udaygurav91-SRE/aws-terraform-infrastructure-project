resource "aws_vpc" "devops_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "DevOps-VPC"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.devops_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-Subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.devops_vpc.id
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.devops_vpc.id
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "rt_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_security_group" "devops_sg" {
  name   = "devops-sg"
  vpc_id = aws_vpc.devops_vpc.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Terraform Server

resource "aws_instance" "terraform_server" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  tags = {
    Name = "Terraform-Server"
  }
}

# Jenkins Server

resource "aws_instance" "jenkins_server" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  user_data = file("scripts/install_jenkins.sh")

  tags = {
    Name = "Jenkins-Server"
  }
}

# App Server

resource "aws_instance" "app_server" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  user_data = file("scripts/install_docker.sh")

  tags = {
    Name = "App-Server"
  }
}
