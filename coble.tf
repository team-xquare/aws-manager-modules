locals {
  coble_type = "school"
  coble_name = "coble"
}

module "coble_account" {
  source = "./modules/account"

  name = local.coble_name
  type = local.coble_type
}

resource "aws_iam_user_policy_attachment" "this" {
  user       = module.coble_account.iam_user_name
  policy_arn = aws_iam_policy.this.arn
}

resource "aws_iam_policy" "this" {
  policy = data.aws_iam_policy_document.this.json
  name   = "${local.coble_name}_additional_policy"
}

data "aws_iam_policy_document" "this" {
  statement {
    actions = [
      "rds:*",
      "ec2:*",
      "s3:*"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
}
