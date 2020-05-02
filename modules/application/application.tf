variable "vpc_id" {
    description = "VPC ID"
}
variable "subnet_id" {
   description = "Subnet ID"
}

variable "name" {
 description = "EC2 instance name"
 default = "app-name"
}

resource "aws_security_group" "allow_http" {
  name = "${var.environment}-${var.name} allow_http"
  description = "Allow HTTP traffic"
  vpc_id = var.vpc_id

  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
}

data "template_file" "user_data" {
  template = "${file("${path.module}/user_data.sh.tpl")}"
  vars = {
    packages = "${var.extra_packages}"
    nameserver = "${var.external_nameserver}"
  }
}

resource "aws_instance" "app-server" {
  ami = "ami-0777ff5c030fe1d38"
  instance_type = "${lookup(var.instance_type, var.environment)}"
  subnet_id = "${var.subnet_id}"
  vpc_security_group_ids = "${distinct(concat(aws_security_group.allow_http.*.id, var.extra_sgs))}"
  user_data = "${data.template_file.user_data.rendered}"
  tags = {
      Name = "${var.environment}-${var.name}"
  }
  lifecycle {
    ignore_changes = [user_data]
  }
}

output "hostname" {
  value = "${aws_instance.app-server.private_dns}"
}

