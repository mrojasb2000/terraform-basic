# Provider configuration
provider "aws" {
  region = "${var.region}"
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
  environment = "${var.environment}"
  name = "${var.name}"
}