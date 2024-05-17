variable "aws_region" {
  default = "us-east-2"
}

variable "vpc_id" {
  default = "vpc-0b6188cf85ce4e65f"
}

variable "subnet_id" {
  default = "subnet-0d31b57f33474bf4e"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "instance_tag_name" {
  default = "HelloWorld_6"
}

# These resources must already exist. I created them here: https://github.com/mmwillingham/github_actions-terraform-aws-backend/blob/main/vars.tf

variable "bucket" {
  default = "bolauder-tfstate2"
}

variable "key" {
  default = "terraform.tfstate"
}

variable "dynamoDB_table" {
  default = "bolauder-tfstate2"
}


