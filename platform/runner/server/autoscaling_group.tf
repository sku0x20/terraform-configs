

resource "aws_autoscaling_group" "server" {

  name_prefix = var.name

  max_size         = 5
  min_size         = 3
  desired_capacity = 3

  launch_template {
    id      = aws_launch_template.server.id
    version = aws_launch_template.server.latest_version
  }

  vpc_zone_identifier = [var.subnet_a]

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

resource "aws_autoscaling_traffic_source_attachment" "server_scale_alb" {
  autoscaling_group_name = aws_autoscaling_group.server.id
  traffic_source {
    identifier = aws_lb_target_group.server_nomad_ui.arn
    type = "elbv2"
  }
}

