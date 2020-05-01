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

module "crazy-foods" {
    source = "./modules/application"
    vpc_id = "${aws_vpc.my_vpc.id}"
    subnet_id = "${aws_subnet.public.id}"
    name = "CrazyFoods ${module.mighty-trousers.hostname}"
}