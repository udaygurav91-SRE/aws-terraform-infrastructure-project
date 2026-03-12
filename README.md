# AWS Terraform Infrastructure Automation

## Project Overview

This project demonstrates **Infrastructure as Code (IaC)** using Terraform to automatically provision cloud infrastructure on AWS.
The goal of this project is to automate the creation of a complete DevOps environment including a Jenkins CI/CD server and an application server running Docker.

Terraform provisions the infrastructure, while initialization scripts configure Jenkins and Docker automatically during instance creation.

---

# Architecture

```
Developer
   |
   | terraform apply
   v
Terraform Server
   |
   v
AWS Infrastructure
   |
------------------------------------------------
|                     |                        |
VPC               Jenkins Server           App Server
                  (CI/CD)                  (Docker)
                                             |
                                             v
                                           Nginx
```

---

# Infrastructure Components

The following resources are created using Terraform:

* VPC
* Public Subnet
* Internet Gateway
* Route Table
* Security Group
* Jenkins EC2 Instance
* Application EC2 Instance

---

# Server Roles

## Terraform Server

This server is used to run Terraform commands to provision infrastructure.

Installed tools:

* Terraform
* AWS CLI
* Git

Main tasks:

* Initialize Terraform
* Plan infrastructure changes
* Apply infrastructure changes

Commands used:

```
terraform init
terraform plan
terraform apply
terraform destroy
```

---

## Jenkins Server

This server acts as the **CI/CD automation tool**.

Installed automatically using a Terraform user_data script.

Components installed:

* Java
* Jenkins

Access Jenkins:

```
http://<JENKINS_PUBLIC_IP>:8080
```

Initial admin password location:

```
/var/lib/jenkins/secrets/initialAdminPassword
```

---

## Application Server

This server hosts containerized applications using Docker.

Installed automatically using a Terraform script.

Components installed:

* Docker
* Nginx container

Test command:

```
docker run -d -p 80:80 nginx
```

Application access:

```
http://<APP_SERVER_PUBLIC_IP>
```

---

# Project Folder Structure

```
aws-terraform-infrastructure-project
│
├── main.tf
├── provider.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
│
├── scripts
│   ├── install_jenkins.sh
│   └── install_docker.sh
│
├── .gitignore
└── README.md
```

---

# Terraform Files Description

### provider.tf

Defines the AWS provider and region.

### variables.tf

Defines variables used in the Terraform configuration.

### terraform.tfvars

Contains variable values such as AMI ID.

### main.tf

Creates the AWS infrastructure including:

* VPC
* Subnet
* Security groups
* EC2 instances

### outputs.tf

Displays important information after deployment such as:

* Jenkins public IP
* Application server IP

---

# Scripts Used

## Jenkins Installation Script

Installs Jenkins automatically during instance creation.

Main steps:

* Install Java
* Add Jenkins repository
* Install Jenkins
* Start Jenkins service

---

## Docker Installation Script

Installs Docker and runs an Nginx container automatically.

Main steps:

* Install Docker
* Start Docker service
* Run Nginx container

---

# Deployment Steps

Clone the repository:

```
git clone https://github.com/YOUR_USERNAME/aws-terraform-infrastructure-project.git
```

Move into project directory:

```
cd aws-terraform-infrastructure-project
```

Initialize Terraform:

```
terraform init
```

Check infrastructure plan:

```
terraform plan
```

Create infrastructure:

```
terraform apply
```

Destroy infrastructure:

```
terraform destroy
```

---

# Security Configuration

Security group allows the following ports:

| Port | Purpose         |
| ---- | --------------- |
| 22   | SSH             |
| 8080 | Jenkins         |
| 80   | Web Application |

---

# Tools and Technologies Used

* AWS
* Terraform
* Jenkins
* Docker
* Git
* GitHub
* Linux

---

# Key DevOps Concepts Demonstrated

* Infrastructure as Code (IaC)
* Automated infrastructure provisioning
* CI/CD setup using Jenkins
* Containerized application deployment
* Cloud infrastructure automation

---

# Future Improvements

Possible enhancements for this project:

* Terraform Remote Backend using S3
* Terraform State Locking using DynamoDB
* Jenkins Pipeline for CI/CD
* Application Load Balancer
* Auto Scaling Group
* Kubernetes deployment

---

# Author

Uday Gurav
DevOps / Cloud Engineer

GitHub Profile:
https://github.com/udaygurav91-SRE
