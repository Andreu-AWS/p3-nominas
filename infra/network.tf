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
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "p3-igw"
  }
}
resource "aws_route_table" "publica" {
  vpc_id = aws_vpc.main.id

  route {

    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id

  }
  tags = {
    Name = "p3-publica-rt"
  }
}

resource "aws_route_table_association" "public-A" {
  subnet_id      = aws_subnet.publica-A.id
  route_table_id = aws_route_table.publica.id
}
resource "aws_route_table_association" "public-B" {
  subnet_id      = aws_subnet.publica-B.id
  route_table_id = aws_route_table.publica.id

}

resource "aws_eip" "nominas" {

  domain = "vpc"
}


resource "aws_nat_gateway" "nominas" {
  allocation_id = aws_eip.nominas.id
  subnet_id     = aws_subnet.publica-A.id

  tags = {
    Name = "nat_gw_nominas"
  }

  depends_on = [aws_internet_gateway.gw]
}



resource "aws_route_table" "privada" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nominas.id
  }

  
  tags = {
    Name = "p3-privada-rt"
  }
}

resource "aws_route_table_association" "privada-A" {
  subnet_id      = aws_subnet.privada-A.id
  route_table_id = aws_route_table.privada.id
}

resource "aws_route_table_association" "privada-B" {
  subnet_id      = aws_subnet.privada-B.id
  route_table_id = aws_route_table.privada.id
}

