region = "us-west-2"
name = "MightyTrousers"
environment = "prod"
vpc_cidr = "172.0.0.0/16"
subnet_cidr = {
    public = "172.0.16.0/24"
    private = "172.0.17.0/24"
}