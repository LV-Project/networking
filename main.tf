module "vpc_and_subnets" {
  source    = "./modules/aws/vpc"
  infra_env = "Networking_Homework_Leo"
  vpc_cidr = "192.168.0.0/20"

  public_subnet_numbers = {
      "us-west-1a" = "192.168.2.192/26"
  }
  
  private_subnet_numbers = {
        "us-west-1a" = "192.168.0.0/23"
        "us-west-1b" = "192.168.2.0/25"	
        "us-west-1c" = "192.168.2.128/26"
  }
}

