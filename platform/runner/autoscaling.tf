

resource "aws_autoscaling_group" "scale" {

  launch_template {
    id      = aws_launch_template.template.id
    version = aws_launch_template.template.latest_version
  }
  vpc_zone_identifier = [var.subnet_a]

  min_size = 0
  max_size = 9

  health_check_grace_period = 300
  health_check_type         = "EC2"

  instance_maintenance_policy {
    min_healthy_percentage = 100
    max_healthy_percentage = 120
  }

  instance_refresh {
    strategy = "Rolling"
  }
}

resource "aws_autoscaling_traffic_source_attachment" "scale-with-nlb" {
  autoscaling_group_name = aws_autoscaling_group.scale.id

  traffic_source {
    identifier = aws_lb_target_group.nlb_http_tg.arn
    type       = "elbv2"
  }
}
