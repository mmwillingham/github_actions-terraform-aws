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
  default = "HelloWorld_5"
}

# These resources must already exist. I created them here: https://github.com/mmwillingham/github_actions-terraform-aws-backend/blob/main/vars.tf

variable "s3_bucket_name" {
  default = "bolauder-tfstate"
}

variable "s3_key" {
  default = "terraform.tfstate"
}

variable "dynamoDB_table_name" {
  default = "bolauder-tfstate"
}


