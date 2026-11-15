resource "aws_vpc" "main" {
  cidr_block = "10.20.0.0/16"
}
#aqui va NAT gateway y ALB
resource "aws_subnet" "publica-A" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.20.1.0/24"
  availability_zone = "eu-south-2a"

  tags = {
    Name = "SB publica A"
  }
}
#aqui va ALB
resource "aws_subnet" "publica-B" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.20.2.0/24"
  availability_zone = "eu-south-2b"

  tags = {
    Name = "SB publica B"
  }
}
#aqui va EC2
resource "aws_subnet" "privada-A" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.20.11.0/24"
  availability_zone = "eu-south-2a"

  tags = {
    Name = "SB privada A"
  }
}
#posible AutoScaling
resource "aws_subnet" "privada-B" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.20.12.0/24"
  availability_zone = "eu-south-2b"

  tags = {
    Name = "SB privada B"
  }
}
#aqui va RDS
resource "aws_subnet" "aislada-A" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.20.21.0/24"
  availability_zone = "eu-south-2a"

  tags = {
    Name = "SB aislada A"
  }
}

resource "aws_subnet" "aislada-B" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.20.22.0/24"
  availability_zone = "eu-south-2b"

  tags = {
    Name = "SB aislada B"
  }
}
