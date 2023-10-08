resource "aws_instance" "east1" {
  ami           = lookup(var.ami_map, var.region_map)
  instance_type = "t3.micro"
   availability_zone = "us-east-1a"
   vpc_security_group_ids = [aws_security_group.private_Security_group_east.id]
   #key_name = "aaru"
   provider = aws.us-east-1
  tags = {
    Name = "East Instance"
  }
}

data "aws_vpc" "vpc" {
  provider = aws.us-east-1
  filter {
    name = "tag:Name"
    values = ["vpc"]
  }
}

resource "aws_security_group" "private_Security_group_east" {
  name        = "private instance SG"
  description = "Allow inbound traffic"
  vpc_id      = "${data.aws_vpc.vpc.id}"

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
    Name = " private Instance"
  }
}
