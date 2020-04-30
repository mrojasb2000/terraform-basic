terraform plan
terraform validate
terraform apply
terraform apply -auto-approve
terraform show
terraform state list
terraform state show <path_resource> ej: terraform state show aws_instance.hello-instance
terraform state show aws_vpc.my_vpc

terraform destroy -auto-approve

terraform fmt


Create infrastructure by code

Repository
Cluster
Load Balancer
Listener
Target Group
Task Definition
Service
$ ./infrastructure/terraform init -backend-config=./backends/ci.tfbackend
$ ./infrastructure/terraform plan
$ ./infrastructure/terraform apply -auto-approve

Destroy infrastructure
$ ./infrastructure/terraform destroy -auto-approve
