variable "environment" {
  default = "dev"
}

variable "instance_type" {
  type = "map"
  default = {
    "dev" = "t3.micro"
    "test" = "t3.medium"
    "prod" = "t3.large"
  }
}

variable "extra_sgs" {
  type = "list"
  default = []
}


