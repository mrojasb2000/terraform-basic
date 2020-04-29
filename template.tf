# Provider configuration
provider "aws" {
  region = "us-west-2"
}

# Resource configuration
resource "aws_instance" "hello-instance" {
  ami = "ami-0777ff5c030fe1d38"
  instance_type = "t2.micro"
  tags = {
      Name = "hello-instance"
  }
}
