locals {
  log_type = "club"
  log_name = "log"
}

module "log_account" {
  source = "./modules/account"

  name = local.log_name
  type = local.log_type
}

resource "aws_iam_user_policy_attachment" "log_this" {
  user       = module.log_account.iam_user_name
  policy_arn = aws_iam_policy.log_this.arn
}

resource "aws_iam_policy" "log_this" {
  policy = data.aws_iam_policy_document.log_this.json
  name   = "${local.log_name}_additional_policy"
}

data "aws_iam_policy_document" "log_this" {
  statement {
    actions = [
      "rds:*",
      "ses:*"
    ]
    resources = ["*"]
    effect    = "Allow"
  }
}
