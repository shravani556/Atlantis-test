
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

# Fetch the latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-*"]  # Amazon Linux 2023 AMI pattern
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"]  # AWS official Amazon Linux AMI account ID
}

# Create an AWS EC2 instance
resource "aws_instance" "amazon_linux_vm" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  tags = {
    Name = "AmazonLinux2023-VM"
  }
}
