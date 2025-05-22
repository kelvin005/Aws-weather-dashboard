#  VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "weather_app_internet_gateway"
  }
}

#  public subnet
resource "aws_subnet" "public_subnet-A" {
  vpc_id  = aws_vpc.main.id
  cidr_block  = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-2a"

  tags = {
    Name = "public-subnet-a"
  }
}
resource "aws_subnet" "public_subnet-B"{
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch =true
  availability_zone = "us-east-2b"
}

#route table for public subnet
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.vpc_cidr_zero
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Associate route table with subnet
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet-A.id
  route_table_id = aws_route_table.route_table.id
}
resource "aws_route_table_association" "public_assoc-2"{
  subnet_id = aws_subnet.public_subnet-B.id
  route_table_id = aws_route_table.route_table.id
}

# Security Group allowing ports 22, 80, 443, 8000 inbound from anywhere
resource "aws_security_group" "sg" {
  name        = "allow_ports_sg"
  description = "Allow ports 22, 80, 443, 8000 inbound"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.vpc_cidr_zero]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [var.vpc_cidr_zero]
  }

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [var.vpc_cidr_zero]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ports_sg"
  }
}

