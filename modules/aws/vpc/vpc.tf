resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "Terraform-${var.infra_env}-vpc"
    ManageBy = "terraform"
  }
}

resource "aws_subnet" "vpc_private_subnets" {
  for_each = var.private_subnet_numbers
  vpc_id = aws_vpc.vpc.id
  cidr_block = each.value

  tags={
      Name = "module-${var.infra_env}-private-subnet"
      Role = "private"
      ManageBy = "terraform"
      Subnet = "${each.key}-leo"
  }
}

resource "aws_subnet" "vpc_public_subnets" {
  for_each = var.public_subnet_numbers
  vpc_id = aws_vpc.vpc.id
  cidr_block = each.value

  tags ={
      Name = "module-${var.infra_env}-public-subnet"
      Role = "public"
      ManageBy = "terraform"
      Subnet = "${each.key}-leo"
  }
}

resource "aws_internet_gateway" "igw_Leo" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.infra_env}-igw_Leo"
  }
}

resource "aws_route_table" "rt_Leo" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_Leo.id
  }

  tags = {
    Name = "my_rt"
  }
}

resource "aws_route_table_association" "Leo_rt_assoc_igw" {
  for_each = var.public_subnet_numbers
  subnet_id      = aws_subnet.vpc_public_subnets[each.key].id
  route_table_id = aws_route_table.rt_Leo.id
}