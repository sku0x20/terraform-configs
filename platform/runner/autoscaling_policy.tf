

resource "aws_autoscaling_policy" "scale" {
  name                   = "manual-scaling"
  autoscaling_group_name = aws_autoscaling_group.scale.name
  adjustment_type        = "ExactCapacity"
  policy_type            = "SimpleScaling"

  scaling_adjustment = 3
}
