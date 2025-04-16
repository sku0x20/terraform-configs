

resource "aws_eip" "client_nlb_eip" {
  domain = "vpc"
  tags = {
    Name = "${var.name}-nlb"
  }
}

resource "aws_lb" "client_nlb" {
  load_balancer_type = "network"
  internal           = false

  subnet_mapping {
    subnet_id     = var.subnet_public
    allocation_id = aws_eip.client_nlb_eip.id
  }

  tags = {
    Name = "${var.name}-nlb"
  }

}

resource "aws_lb_listener" "client_nlb_listener_http" {
  load_balancer_arn = aws_lb.client_nlb.arn
  port = 80
  protocol = "TCP_UDP"

  default_action {
    target_group_arn = aws_lb_target_group.client_nlb_tg.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group" "client_nlb_tg" {
  port               = 8080
  protocol           = "TCP_UDP"
  preserve_client_ip = true
  vpc_id             = var.vpc_id

  health_check {
    path = "/v1/agent/health"
  }
}
