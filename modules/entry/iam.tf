data "aws_iam_policy_document" "this" {
  statement {
    actions = [
      "iam:ChangePassword",
      "iam:ListPoliciesGrantingServiceAccess",
      "iam:ListUsers"
    ]
    resources = ["*"]
    effect = "Allow"
  }

  statement {
    actions = [
      "ec2:*",
      "rds:*",
      "ecr:*",
      "elasticache:*",
      "route53:*",
      "acm:*",
      "ecs:*",
      "elasticloadbalancing:*",
      "kafka:*",
      "cloudwatch:DescribeAlarms",
      "kms:List*"
    ]
    resources = ["*"]
    effect = "Allow"
  }

  statement {
    actions = ["*"]
    resources = ["*"]
    effect = "Allow"
    condition {
      test = "StringEquals"
      variable = "aws:RequestTag/project"
      values = [var.entry_name]
    }
    condition {
      test = "StringEquals"
      variable = "aws:RequestTag/type"
      values = [var.entry_type]
    }
  }

  statement {
    actions = ["*"]
    resources = ["*"]
    effect = "Allow"
    condition {
      test = "StringEquals"
      variable = "aws:ResourceTag/project"
      values = [var.entry_name]
    }
    condition {
      test = "StringEquals"
      variable = "aws:ResourceTag/type"
      values = [var.entry_type]
    }
  }
}

resource "aws_iam_policy" "this" {
  name   = "${var.entry_name}_policy"
  policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_user_policy_attachment" "this" {
  user       = aws_iam_user.this.name
  policy_arn = aws_iam_policy.this.arn
}

resource "aws_iam_user" "this" {
  name = "${var.entry_name}_iam_user"
  tags = {
    "project" = var.entry_name
    "type"    = var.entry_type
  }
}

resource "aws_iam_user_login_profile" "this" {
  user                    = aws_iam_user.this.name
  password_length         = 20
  password_reset_required = true
  lifecycle {
    ignore_changes = [password_reset_required]
  }
}
