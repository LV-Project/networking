resource "aws_security_group" "sg_Leo_public_instances" {
  vpc_id = "${var.vpc_id}"
  name = "public_sg_Leo"

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



resource "aws_security_group" "sg_Leo_private_instances" {
  
  vpc_id = "${var.vpc_id}"
  name = "private_sg_Leo"

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = var.aws_sg_ssh_ingress
  }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  
}

resource "aws_key_pair" "Leo_key_pair" {
  key_name = "LeonardoVillalba"
  public_key = file("/home/vscode/.ssh/key.pub")

}

resource "aws_instance" "ec2_Leo_public_instances" {
    for_each = var.public_subnet_numbers

    subnet_id = "${var.public_subnet_numbers[each.value]}"
    ami = "${var.ami_public_ec2}"
    instance_type = "${var.instance_type}"
    key_name = aws_key_pair.Leo_key_pair.key_name
    vpc_security_group_ids = ["${aws_security_group.sg_Leo_public_instances.id}"]
    associate_public_ip_address=true
    tags = {
    name = "public"
  }
}

resource "aws_instance" "ec2_Leo_private_instances" {
    for_each = var.private_subnet_numbers

    subnet_id = "${var.private_subnet_numbers[each.value]}"
    ami = "${var.ami_private_ec2}"
    instance_type = "${var.instance_type}"
    key_name = aws_key_pair.Leo_key_pair.key_name
    vpc_security_group_ids = ["${aws_security_group.sg_Leo_private_instances.id}"]
#    associate_public_ip_address=true
  tags = {
    name = "private"
  }
}