resource "aws_s3_bucket" "this" {
  bucket = "dsm-s3-bucket-${var.entry_name}"

  tags = {
    project = var.entry_name
    type = var.entry_type
  }
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.public_access_bucket_policy_document.json
}

data "aws_iam_policy_document" "public_access_bucket_policy_document" {
  version = "2012-10-17"
  policy_id = "Policy1693145575478"

  statement {
    effect = "Allow"
    actions = ["s3:GetObject"]
    resources = [
      aws_s3_bucket.this.arn,
      "${aws_s3_bucket.this.arn}/*"
    ]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
  statement {
    effect = "Allow"
    actions = ["s3:*"]
    resources = [
      aws_s3_bucket.this.arn,
      "${aws_s3_bucket.this.arn}/*"
    ]
    principals {
      type        = "AWS"
      identifiers = [aws_iam_user.this.arn]
    }
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}