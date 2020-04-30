# Provider configuration
provider "aws" {
  region = "us-west-2"
}

# Resource configuration
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public" {
  vpc_id =  "${aws_vpc.my_vpc.id}"
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "public"
  }
}

resource "aws_instance" "hello-instance" {
  ami = "ami-0777ff5c030fe1d38"
  instance_type = "t2.micro"
  tags = {
      Name = "hello-instance"
  }
}
