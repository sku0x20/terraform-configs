

resource "aws_autoscaling_group" "scale" {

  launch_template {
    id = aws_launch_template.template.id
    version = aws_launch_template.template.latest_version
  }
  vpc_zone_identifier = [var.subnet_id]

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
