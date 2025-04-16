
resource "aws_iam_instance_profile" "client" {
  name = var.name
  role = aws_iam_role.client.id
}

resource "aws_iam_role" "client" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.client_assume.json
}

data "aws_iam_policy_document" "client_assume" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy_attachment" "client" {
  role       = aws_iam_role.client.id
  policy_arn = aws_iam_policy.client.arn
}

resource "aws_iam_policy" "client" {
  name   = var.name
  policy = data.aws_iam_policy_document.client_policy.json
}

data "aws_iam_policy_document" "client_policy" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:DescribeInstances"]
    resources = ["*"]
  }
}
