
data "aws_iam_policy_document" "this" {
  statement {
    actions = [
      "iam:ChangePassword",
      "iam:ListPoliciesGrantingServiceAccess",
      "iam:ListUsers"
    ]
    resources = ["*"]
    effect    = "Allow"
  }

  statement {
    actions   = [
      "ec2:Describe*",
      "ec2:CreateKeyPair",
      "ec2:CreateSecurityGroup",
      "rds:Describe*",
      "s3:ListAllMyBuckets",
      "cloudwatch:DescribeAlarms",
      "kms:List*"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
  
  statement {
    actions   = ["*"]
    resources = [
      aws_s3_bucket.this.arn,
      "${aws_s3_bucket.this.arn}/*"
    ]
    effect    = "Allow"
  }

  statement {
    actions = ["ec2:RunInstances"]
    resources = [
      "arn:aws:ec2:*:*:subnet/*",
      "arn:aws:ec2:*::image/*",
      "arn:aws:ec2:*:*:key-pair/*"
    ]
    effect    = "Allow"
  }

  statement {
    actions = ["*"]
    resources = [
      "arn:aws:ec2:*:*:security-group/*",
    ]
    effect    = "Allow"
  }

  statement {
    actions = ["*"]
    resources = ["*"]
    effect    = "Allow"
    condition {
      test     = "StringEquals"
      variable = "aws:RequestTag/project"
      values   = [var.name]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:RequestTag/type"
      values   = [var.type]
    }
  }

  statement {
    actions   = ["*"]
    resources = ["*"]
    effect    = "Allow"

    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/project"
      values   = [var.name]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/type"
      values   = [var.type]
    }
  }
}

resource "aws_iam_policy" "this" {
  name        = "${var.name}_policy"
  policy      = data.aws_iam_policy_document.this.json
}

resource "aws_iam_user_policy_attachment" "this" {
  user       = aws_iam_user.this.name
  policy_arn = aws_iam_policy.this.arn
}

resource "aws_iam_user" "this" {
  name = "${var.name}_iam_user"
  tags = {
    "project" = var.name
    "type" = var.type
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
