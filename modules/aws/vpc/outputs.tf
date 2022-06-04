output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}

output "rt_id" {
  value= aws_route_table.rt_Leo.id
}

output "vpc_public_subnets" {

    value = {
        for subnet in aws_subnet.vpc_public_subnets :
        subnet.id => subnet.id
    }
}

output "vpc_private_subnets" {

    value = {
        for subnet in aws_subnet.vpc_private_subnets :
        subnet.id => subnet.id
    }
}