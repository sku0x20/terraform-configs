

resource "aws_lb" "server_alb" {
  load_balancer_type = "application"
  internal           = false

  subnets = [var.subnet_public, var.subnet_public_b]

  security_groups = [aws_security_group.server_alb.id]

  tags = {
    Name = "${var.name}-alb"
  }
}

resource "aws_lb_listener" "server_nomad_listener" {
  load_balancer_arn = aws_lb.server_alb.arn
  port              = 8080
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.server_nomad_ui.arn
    type             = "forward"
  }
}


resource "aws_lb_target_group" "server_nomad_ui" {
  port     = 4646
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/ui/"
  }
}
