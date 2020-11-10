resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "terraform-ecs-deployment-${var.env_name}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "igw-terraform-ecs-deployment-${var.env_name}"
  }
}

resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public-route-table-terraform-ecs-deployment-${var.env_name}"
  }
}

resource "aws_subnet" "public-0" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = "subnet-public-1a"
  }
}

resource "aws_route_table_association" "public-association" {
  subnet_id = aws_subnet.public-0.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_subnet" "private-0" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.65.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = false
}

resource "aws_subnet" "private-1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.66.0/24"
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = false
}

resource "aws_security_group" "security-group" {
  name        = "security-group-${var.env_name}"
  vpc_id      = aws_vpc.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_vpc_endpoint" "ecr_api" {
  service_name        = "com.amazonaws.ap-northeast-1.ecr.api"
  vpc_endpoint_type   = "Interface"
  vpc_id              = aws_vpc.vpc.id
  subnet_ids          = [aws_subnet.private-0.id, aws_subnet.private-1.id]
  security_group_ids  = [aws_security_group.security-group.id]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  service_name        = "com.amazonaws.ap-northeast-1.ecr.dkr"
  vpc_endpoint_type   = "Interface"
  vpc_id              = aws_vpc.vpc.id
  subnet_ids          = [aws_subnet.private-0.id, aws_subnet.private-1.id]
  security_group_ids  = [aws_security_group.security-group.id]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ecr_logs" {
  service_name        = "com.amazonaws.ap-northeast-1.logs"
  vpc_endpoint_type   = "Interface"
  vpc_id              = aws_vpc.vpc.id
  subnet_ids          = [aws_subnet.private-0.id, aws_subnet.private-1.id]
  security_group_ids  = [aws_security_group.security-group.id]
  private_dns_enabled = true
}
