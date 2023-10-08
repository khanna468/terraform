resource "aws_instance" "private_instance_vpcb" {
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t3.micro"
   availability_zone = var.availability_zone_b
   subnet_id = aws_subnet.vpcb_private_subnet.id
   vpc_security_group_ids = [aws_security_group.private_Security_group.id]
   key_name = "aaru"
   provider = aws.ap-south-1
  tags = {
    Name = "VPCB Private Instance"
  }
}

resource "aws_security_group" "private_Security_group" {
  name        = "Pub instance SG"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.vpcb.id

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
  

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "VPCB private Instance"
  }
}
