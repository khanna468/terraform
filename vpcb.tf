resource "aws_vpc" "vpcb" {
  cidr_block       = "192.168.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "VPC-B"
  }
}

######################Internet Gateway#################
resource "aws_internet_gateway" "vpcb-igw" {
  vpc_id = aws_vpc.vpcb.id

  tags = {
    Name = "VPCB Internet gateway"
  }
  depends_on = [ aws_vpc.vpcb ]
}

################EIP FOR NAT Gateway###############

resource "aws_eip" "nat_vpcb" {
  tags = {
    Name = "NAT EIP VPCB"
  }
}

#################NAT Gateway#########################
resource "aws_nat_gateway" "vpcb-ngw" {
  allocation_id = aws_eip.nat_vpcb.id
  subnet_id     = aws_subnet.vpcb_public_subnet.id

  tags = {
    Name = "VPCB NAT Gateway"
  }
}

################Public Route#############################
resource "aws_route_table" "vpcb_internet_gateway_route" {
  vpc_id = aws_vpc.vpcb.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpcb-igw.id
  }
 route {
    cidr_block = "10.0.0.0/16"
    vpc_peering_connection_id= aws_vpc_peering_connection.assignment.id
  }

  tags = {
    Name = "VPCB Internet Gateway Route"
  }
}

#########################Private Route######################
resource "aws_route_table" "vpcb_nat_gateway_route" {
  vpc_id = aws_vpc.vpcb.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.vpcb-ngw.id
  }
  route {
    cidr_block = "10.0.0.0/16"
    vpc_peering_connection_id= aws_vpc_peering_connection.assignment.id
  }
  tags = {
    Name = "VPCB Nat Gateway Route"
  }
}

################Public Subnet################
resource "aws_subnet" "vpcb_public_subnet" {
  vpc_id     = aws_vpc.vpcb.id
  cidr_block = "192.168.0.0/20"
  availability_zone = var.availability_zone_a

  tags = {
    Name = "VPCB Public Subnet"
  }
}

################Private Subnet################
resource "aws_subnet" "vpcb_private_subnet" {
  vpc_id     = aws_vpc.vpcb.id
  cidr_block = "192.168.16.0/20"
  availability_zone = var.availability_zone_b
  tags = {
    Name = "VPCB Private Subnet"
  }
}


#############Public Route Table Association########################3
resource "aws_route_table_association" "internet_gateway_association_vpcb" {
  subnet_id      = aws_subnet.vpcb_public_subnet.id
  route_table_id = aws_route_table.vpcb_internet_gateway_route.id
}

#############Private Route Table Association########################3
resource "aws_route_table_association" "nat_gateway_association_vpcb" {
  subnet_id      = aws_subnet.vpcb_private_subnet.id
  route_table_id = aws_route_table.vpcb_nat_gateway_route.id
}
