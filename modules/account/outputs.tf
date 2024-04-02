output "project_name" {
  value = aws_iam_user.this.tags.project
}

output "type" {
  value = aws_iam_user.this.tags.type
}

output "iam_user_name" {
  value = aws_iam_user.this.name
}

output "iam_user_password" {
  value = aws_iam_user_login_profile.this.password
  sensitive = true
}

output "s3_bucket_name" {
  value = aws_s3_bucket.this.bucket_domain_name
}


