# VIM TEXT OBJECTS PRACTICE
# Practice file for Steps 5-8: Text objects (iw, aw, i", a", i{, a{) and operators (d, c, y)

# Provider configuration
# Practice text objects and operators:
# - ci" - change inside quotes
# - ca{ - change a block including braces
# - di( - delete inside parentheses
# - yi[ - yank (copy) inside brackets

provider "aws" {
  region  = "us-west-2"
  profile = "production"

  default_tags {
    tags = {
      Environment = "Production"
      ManagedBy   = "Terraform"
      Project     = "DevOpsInfrastructure"
    }
  }
}

# Backend configuration for state storage
terraform {
  backend "s3" {
    bucket         = "terraform-state-devops"
    key            = "infrastructure/production/terraform.tfstate"
    region         = "us-west-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

# Variables
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "production"
}

variable "instance_types" {
  description = "EC2 instance types to use per environment"
  type        = map(string)
  default = {
    development = "t3.micro",
    staging     = "t3.medium",
    production  = "t3.large"
  }
}

variable "subnet_cidrs" {
  description = "CIDR blocks for subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

# Resource definitions
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.environment}-vpc"
  }
}

resource "aws_subnet" "public" {
  count             = length(var.subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidrs[count.index]
  availability_zone = element(["us-west-2a", "us-west-2b", "us-west-2c"], count.index)

  tags = {
    Name = "${var.environment}-public-subnet-${count.index + 1}"
  }
}

resource "aws_security_group" "web" {
  name        = "${var.environment}-web-sg"
  description = "Security group for web servers"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP traffic"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS traffic"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
    description = "Allow SSH from internal network"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "${var.environment}-web-sg"
  }
}

resource "aws_instance" "web_server" {
  count         = 3
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = var.instance_types[var.environment]

  subnet_id                   = aws_subnet.public[count.index].id
  vpc_security_group_ids      = [aws_security_group.web.id]
  associate_public_ip_address = true

  root_block_device {
    volume_size           = 20
    volume_type           = "gp3"
    delete_on_termination = true
    encrypted             = true
  }

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello from Terraform!"
              apt-get update
              apt-get install -y nginx
              systemctl enable nginx
              systemctl start nginx
              echo "<h1>Hello from $(hostname)</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "${var.environment}-web-server-${count.index + 1}"
  }
}

# Output values
output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "instance_ips" {
  description = "Public IP addresses of web servers"
  value       = aws_instance.web_server[*].public_ip
}

output "security_group_id" {
  description = "Security group ID for web servers"
  value       = aws_security_group.web.id
}

# Local values for reference
locals {
  service_name = "web-platform"
  team         = "devops"
  owner        = "infrastructure-team@example.com"
  cost_center  = "cc-123456"

  common_tags = {
    Service    = local.service_name
    Team       = local.team
    Owner      = local.owner
    CostCenter = local.cost_center
    Terraform  = "true"
  }
}
