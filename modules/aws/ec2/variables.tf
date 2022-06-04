variable "aws_sg_ssh_ingress" {
    type = list
    description="subnet public id to allow ssh connection to private ec2"
}

variable "aws_sg_ssh_ingress_internet" {
    type = string
    description="connect shh from anywhere"
}

variable "ami_private_ec2" {
    type = string
    description = "ami for ec2 in private subnets"
}

variable "ami_public_ec2" {
    type = string
    description = "ami for ec2 in public subnets"
}

variable "instance_type" {
    type = string
    description = "instance type - t2.micro freemium"
}

variable "vpc_id" {
  type = string
  description = "vpc id"
}

variable "public_subnet_numbers" {
    type = map(string)
    description = "Map of AZ to a number that should be used for public subnets"

}
variable "private_subnet_numbers" {
    type = map(string)
    description = "Map of AZ to a number that should be used for private subnets"

}