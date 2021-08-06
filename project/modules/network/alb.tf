#Application Load Balancer
resource "aws_alb" "alb" {
  load_balancer_type = "application"
  subnets            = aws_subnet.public_subnet.*.id
  security_groups    = [aws_security_group.alb.id]

  tags = {
    Name = "${var.app}_${var.env}_alb"
  }
}

#ALB Listener
resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.alb.id
  port              = var.app_port
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.web_server.id
    type             = "forward"
  }
}

#Security Group for ALB
resource "aws_security_group" "alb" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.app}_${var.env}_sg_alb"
  }

  ingress {
    protocol    = "tcp"
    from_port   = var.app_port
    to_port     = var.app_port
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Target Group and Targets for ALB
resource "aws_alb_target_group" "web_server" {
  port     = var.app_target_port
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  tags = {
    Name = "${var.app}_${var.env}_tg"
  }

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.health_check_path
    unhealthy_threshold = "2"
  }
}

resource "aws_lb_target_group_attachment" "web_server" {
  count            = length(aws_instance.web_server)
  target_group_arn = aws_alb_target_group.web_server.arn
  target_id        = aws_instance.web_server[count.index].id
  port             = var.app_target_port
}
