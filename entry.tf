locals {
  entry_type = "school"
  entry_name = "entry"
}

module "entry_account" {
  source = "./modules/account"

  name = local.entry_name
  type = local.entry_type
}

resource "aws_iam_user_policy_attachment" "this" {
  user       = module.entry_account.iam_user_name
  policy_arn = aws_iam_policy.this.arn
}

resource "aws_iam_policy" "this" {
  policy = data.aws_iam_policy_document.this.json
  name   = "${local.entry_name}_additional_policy"
}

data "aws_iam_policy_document" "this" {
  statement {
    actions = [
      "rds:*",
      "ecr:*",
      "elasticache:*",
      "route53:*",
      "acm:*",
      "ecs:*",
      "elasticloadbalancing:*",
      "kafka:*",
      "ec2:CreateVpc",
      "iam:CreateRole",
      "s3:CreateBucket"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
}
