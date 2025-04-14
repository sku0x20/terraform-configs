
resource "aws_iam_instance_profile" "server" {
  name = var.name
  role = aws_iam_role.server.id
}

resource "aws_iam_role" "server" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.server_assume.json
}

data "aws_iam_policy_document" "server_assume" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy_attachment" "server" {
  role       = aws_iam_role.server.id
  policy_arn = aws_iam_policy.server.arn
}

resource "aws_iam_policy" "server" {
  name   = var.name
  policy = data.aws_iam_policy_document.server_policy
}

data "aws_iam_policy_document" "server_policy" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:DescribeInstances"]
    resources = ["*"]
  }
}
