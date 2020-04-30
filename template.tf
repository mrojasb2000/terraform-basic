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

module "mighty-trousers" {
  source = "./modules/application"
  vpc_id = "${aws_vpc.my_vpc.id}"
  subnet_id = "${aws_subnet.public.id}"
  name = "MightyTrousers"
}


/*
resource "aws_instance" "master-instance" {
  ami = "ami-0777ff5c030fe1d38"
  instance_type = "t3.micro"
  subnet_id = "${aws_subnet.public.id}"
  tags = {
      Name = "master-instance"
  }
}

resource "aws_instance" "slave-instance" {
  ami = "ami-0777ff5c030fe1d38"
  instance_type = "t3.micro"
  subnet_id = "${aws_subnet.public.id}"
  depends_on = [
    aws_instance.master-instance,
  ]
  tags = {
      master_hostname = "${aws_instance.master-instance.private_dns}"
      Name = "slave-instance"
  }
  lifecycle {
    ignore_changes = [
        tags
    ]
  }
}*/