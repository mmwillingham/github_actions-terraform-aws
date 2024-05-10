terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
    }

    random = {
      source  = "hashicorp/random"
      version >= "3.4.3"
    }
  }
  
  backend "s3" {
    bucket         	   = "bolauder-tfstate"
    key              	   = "terraform.tfstate"
    region         	   = "us-east-2"
    encrypt        	   = true
    dynamodb_table = "bolauder-tfstate"
  }
}

provider "aws" {
  region     = "${var.aws_region}"
}

resource "random_pet" "sg" {}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "${var.instance_type}"
  tags = {
    Name = "${var.instance_tag_name}"
  }
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  subnet_id = "${var.subnet_id}"

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              sed -i -e 's/80/8080/' /etc/apache2/ports.conf
              echo "Hello World" > /var/www/html/index.html
              systemctl restart apache2
              EOF
}

resource "aws_security_group" "web-sg" {
  vpc_id = "${var.vpc_id}"
  name = "${random_pet.sg.id}-sg"
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  // connectivity to ubuntu mirrors is required to run `apt-get update` and `apt-get install apache2`
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "web-address" {
  value = "${aws_instance.web.public_dns}:8080"
}
