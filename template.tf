# Provider configuration
provider "aws" {
  region = var.region
}

# Resource configuration
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public" {
  vpc_id =  aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "public"
  }
}

resource "aws_security_group" "default" {
  name = "Default SG"
  description = "Allow SSH access"
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "terraform" {
  key_name = "terraform"
  public_key = "${file("./keys/aws_terraform.pub")}"
}

/*
resource "aws_iam_role_policy" "s3-assets-all" {
  name = "s3=assets@all"
  role = "${aws_iam_role.app-production.id}"
  policy = "${file("./policies/s3=assets@all.json")}"
}*/

module "mighty-trousers" {
  source = "./modules/application"
  vpc_id = "${aws_vpc.my_vpc.id}"
  subnet_id = "${aws_subnet.public.id}"
  environment = "${var.environment}"
  name = "${var.name}"
  extra_sgs = ["${aws_security_group.default.id}"]
  extra_packages = "${var.extra_packages}"
  external_nameserver = "${var.external_nameserver}"
}