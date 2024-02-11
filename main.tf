resource "aws_vpc" "default" {
  cidr_block = "172.0.0.0/16"
  tags = {
    Name = "myproject-${var.env}"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = "172.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone
  tags = {
    Name = "PublicSubnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = "172.0.2.0/24"
  availability_zone = var.availability_zone
  tags = {
    Name = "PrivateSubnet"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = "172.0.3.0/24"
  availability_zone = var.availability_zone_2
  tags = {
    Name = "PrivateSubnet-2"
  }
}

resource "aws_instance" "default" {
  ami               = var.ec2_ami
  instance_type     = var.instance_type
  subnet_id         = aws_subnet.public_subnet.id
  availability_zone = var.availability_zone

  tags = {
    Name = "default-${var.env}"
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "default-db-subnet-group-${var.env}"
  subnet_ids = [aws_subnet.private_subnet.id, aws_subnet.private_subnet_2.id]

  tags = {
    Name = "My ${var.env} DB subnet group"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  db_name              = "mydb${var.env}"
  username             = "defaultsa"
  password             = "defaultsa"
  db_subnet_group_name = aws_db_subnet_group.default.name
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true

  tags = {
    Name = "default-mysqldb-${var.env}"
  }
}