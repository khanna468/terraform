resource "aws_eip" "pub_instance_eip" {
  tags = {
    Name = "Pubinstance EIP"
  }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.pub_instance.id
  allocation_id = aws_eip.pub_instance_eip.id
}

resource "aws_instance" "pub_instance" {
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t3.micro"
   availability_zone = var.availability_zone_a
   subnet_id = aws_subnet.vpca_public_subnet.id
   vpc_security_group_ids = [aws_security_group.public_Security_group.id]
   key_name = "aaru"
  tags = {
    Name = "VPCA Public Instance"
  }
}

resource "aws_security_group" "public_Security_group" {
  name        = "Pub instance SG"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.vpca.id
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "VPCA Public Instance"
  }
}
