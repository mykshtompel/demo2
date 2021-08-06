#Bastion Servers (with Security Group) in Public Networks
resource "aws_instance" "bastion_server" {
  count         = local.number_bastion_servers
  ami           = "ami-0b9064170e32bde34"
  instance_type = "t2.micro"
  key_name      = "server"
  user_data = templatefile("${path.module}/user_data.tftpl", {
    app_port        = var.app_port,
    app_target_port = var.app_target_port
  })
  availability_zone      = local.azs[count.index]
  subnet_id              = aws_subnet.public_subnet[count.index].id
  vpc_security_group_ids = [aws_security_group.sg_bastion_server.id]

  tags = {
    Name = "${var.app}_${var.env}_bastion_server_${count.index + 1}_${substr(local.azs[count.index], -2, 2)}"
  }
}

resource "aws_security_group" "sg_bastion_server" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app}_${var.env}_security_group_bastion_server"
  }
}

#Web Servers (with Security Group) in Private Networks
resource "aws_instance" "web_server" {
  count         = local.number_web_servers
  ami           = "ami-0b9064170e32bde34"
  instance_type = "t2.micro"
  key_name      = "server"
  user_data = templatefile("${path.module}/user_data.tftpl", {
    app_port        = var.app_port,
    app_target_port = var.app_target_port
  })
  availability_zone      = local.azs[count.index]
  subnet_id              = aws_subnet.private_subnet[count.index].id
  vpc_security_group_ids = [aws_security_group.sg_web_server.id]


  tags = {
    Name = "${var.app}_${var.env}_web_server_${count.index + 1}_${substr(local.azs[count.index], -2, 2)}"
  }
}

resource "aws_security_group" "sg_web_server" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }

  ingress {
    from_port   = var.app_target_port
    to_port     = var.app_target_port
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app}_${var.env}_security_group_web_server"
  }
}
