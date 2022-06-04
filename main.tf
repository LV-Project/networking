module "vpc_and_subnets" {
  source    = "./modules/aws/vpc"
  infra_env = "Networking_Homework_Leo"
  vpc_cidr  = "192.168.0.0/20"

  public_subnet_numbers = {
    "us-west-1a" = "192.168.2.192/26"
  }

  private_subnet_numbers = {
    "us-west-1a" = "192.168.0.0/23"
    "us-west-1b" = "192.168.2.0/25"
    "us-west-1c" = "192.168.2.128/26"
  }
}

resource "aws_route_table_association" "Leo_rt_assoc_igw" {
  for_each = module.vpc_and_subnets.vpc_public_subnets
  subnet_id      = module.vpc_and_subnets.vpc_public_subnets[each.value]
  route_table_id = module.vpc_and_subnets.rt_id
}

module "ec2_instances" {
  source = "./modules/aws/ec2"

  aws_sg_ssh_ingress          = ["192.168.2.192/26"]
  aws_sg_ssh_ingress_internet = "0.0.0.0/0"

  ami_private_ec2 = "ami-0487b1fe60c1fd1a2"
  ami_public_ec2  = "ami-0487b1fe60c1fd1a2"

  instance_type = "t2.micro"
  vpc_id        = module.vpc_and_subnets.vpc_id

  public_subnet_numbers  = module.vpc_and_subnets.vpc_public_subnets
  private_subnet_numbers = module.vpc_and_subnets.vpc_private_subnets
}
