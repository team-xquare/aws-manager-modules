locals {
  club_type = "club" // 전공동아리
  club_account = [
    "modeep",
    "info"
  ]
  school_type = "school" // 학교 프로젝트
  school_account = [
    "jobis",
    "repo"
  ]
  class_type = "class" // 수업
  class_account = [
  ]
}

module "club_account" {

  source = "./modules/account"

  for_each = toset(local.club_account)
  name     = each.value
  type     = "club"
}

module "school_account" {

  source = "./modules/account"

  for_each = toset(local.school_account)
  name     = each.value
  type     = "school"
}

module "class_account" {

  source = "./modules/account"

  for_each = toset(local.class_account)
  name     = each.value
  type     = "class"
}

output "club_password" {
  sensitive = true
  value = [
    for v in module.club_account : v.iam_user_password
  ]
}

output "school_password" {
  sensitive = true
  value = [
    for v in module.school_account : v.iam_user_password
  ]
}

output "class_password" {
  sensitive = true
  value = [
    for v in module.class_account : v.iam_user_password
  ]
}

