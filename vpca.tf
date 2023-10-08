resource "aws_vpc" "vpca" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "VPC-A"
  }
}

######################Internet Gateway#################
resource "aws_internet_gateway" "vpca-igw" {
  vpc_id = aws_vpc.vpca.id

  tags = {
    Name = "VPCA Internet gateway"
  }
  depends_on = [ aws_vpc.vpca ]
}

################EIP FOR NAT Gateway###############

resource "aws_eip" "nat" {
  tags = {
    Name = "NAT EIP"
  }
}

#################NAT Gateway#########################
resource "aws_nat_gateway" "vpca-ngw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.vpca_public_subnet.id

  tags = {
    Name = "VPCA NAT Gateway"
  }
}

################Public Route#############################
resource "aws_route_table" "vpca_internet_gateway_route" {
  vpc_id = aws_vpc.vpca.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpca-igw.id
  }
  
  route {
    cidr_block = "192.168.0.0/16"
    vpc_peering_connection_id= aws_vpc_peering_connection.assignment.id
  }
  tags = {
    Name = "VPCA Internet Gateway Route"
  }
}

#########################Private Route######################
resource "aws_route_table" "vpca_nat_gateway_route" {
  vpc_id = aws_vpc.vpca.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.vpca-ngw.id
  }

  tags = {
    Name = "VPCA Nat Gateway Route"
  }
}

################Public Subnet################
resource "aws_subnet" "vpca_public_subnet" {
  vpc_id     = aws_vpc.vpca.id
  cidr_block = "10.0.0.0/20"
  availability_zone = var.availability_zone_a

  tags = {
    Name = "VPCA Public Subnet"
  }
}

################Private Subnet################
resource "aws_subnet" "vpca_private_subnet" {
  vpc_id     = aws_vpc.vpca.id
  cidr_block = "10.0.16.0/20"
  availability_zone = var.availability_zone_b
  tags = {
    Name = "VPCA Private Subnet"
  }
}

#############Public Route Table Association########################3
resource "aws_route_table_association" "internet_gateway_association" {
  subnet_id      = aws_subnet.vpca_public_subnet.id
  route_table_id = aws_route_table.vpca_internet_gateway_route.id
}

#############Private Route Table Association########################3
resource "aws_route_table_association" "nat_gateway_association" {
  subnet_id      = aws_subnet.vpca_private_subnet.id
  route_table_id = aws_route_table.vpca_nat_gateway_route.id
}
