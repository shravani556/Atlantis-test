
############ PROVIDER BLOCK ############
provider "aws" {
  region     = "us-east-1"
  profile    = "default"
}
############ SAVING TF STATE FILE #########
terraform {
  backend "s3" {
    bucket  = "terraform-atlantis-bucket"
    key     = "atlantis/terraform.tfstate"
    region  = "us-east-1"
    profile = "default"
  }
}
################# EC2 INSTANCE CREATION #########
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

  owners = ["099720109477"]
}

resource "aws_instance" "mydemo_instance" {
  ami           = "ami-0c614dee691cbbf37" # Amazon Linux 2023 AMI ID (Change based on your region)
  instance_type = "t2.micro"
 
  tags = {
    Name = "MyAmazon2023VM1"
  }
}
