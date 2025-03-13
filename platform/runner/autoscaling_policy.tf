

resource "aws_autoscaling_policy" "scale_3" {
  name                   = "scale-to-3"
  autoscaling_group_name = aws_autoscaling_group.scale.name
  adjustment_type        = "ExactCapacity"
  policy_type            = "SimpleScaling"

  scaling_adjustment = 3
}

resource "aws_autoscaling_policy" "scale_0" {
  name                   = "scale-to-0"
  autoscaling_group_name = aws_autoscaling_group.scale.name
  adjustment_type        = "ExactCapacity"
  policy_type            = "SimpleScaling"

  scaling_adjustment = 0
}