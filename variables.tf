variable "region" {
    // "us-west-2"
    description = "Amazon region. Changing it will lead to loss of complete stack."
    default = "eu-central-1"
}

variable "environment" {
  default = "prod"
}


variable "name" {
 description = "EC2 instance name"
}


