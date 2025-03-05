data "aws_iam_policy_document" "ec2_role_policy_doc" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:DescribeInstances"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ec2_role_policy" {
  name   = "${var.name}-ec2-role-policy"
  policy = data.aws_iam_policy_document.ec2_role_policy_doc.json
}

data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "ec2_role" {
  name               = "${var.name}-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}

resource "aws_iam_role_policy_attachment" "ec2_role_policy_attachment" {
  role       = aws_iam_role.ec2_role.id
  policy_arn = aws_iam_policy.ec2_role_policy.arn
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${var.name}-ec2-instance-profile"
  role = aws_iam_role.ec2_role.id
}
