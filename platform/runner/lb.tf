
resource "aws_eip" "nlb_eip" {
  domain = "vpc"
  tags = {
    Name = "${var.name}-nlb"
  }
}

resource "aws_lb" "nlb" {
  load_balancer_type = "network"
  internal           = false

  subnet_mapping {
    subnet_id     = var.subnet_public
    allocation_id = aws_eip.nlb_eip.id
  }

  tags = {
    Name = "${var.name}-nlb"
  }

}

resource "aws_lb_listener" "nlb_listener_http" {
  load_balancer_arn = aws_lb.nlb.arn
  port = 80
  protocol = "TCP_UDP"

  default_action {
    target_group_arn = aws_lb_target_group.nlb_http_tg.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group" "nlb_http_tg" {
  port               = 8080
  protocol           = "TCP_UDP"
  preserve_client_ip = true
  vpc_id             = var.vpc_id
}
