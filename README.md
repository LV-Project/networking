**Networking**

Author: Leonardo Villalba

The goal in this project was to use terraform to 

first make a plan of the vpc module because the ec2 module depends on map value there
terraform plan -target=module.vpc_and_subnets -out main.tfplan

then apply terraform apply -target=module.vpc_and_subnets