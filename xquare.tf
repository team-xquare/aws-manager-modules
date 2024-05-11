locals {
  xquare_type = "school"
  xquare_name = "xquare"
}

module "xquare_account" {
  source = "./modules/account"

  name = local.xquare_name
  type = local.xquare_type
}

resource "aws_iam_user_policy_attachment" "xquare_user_admin_policy_attachment" {
  user       = module.xquare_account.iam_user_name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess" 
}

