resource "aws_s3_bucket" "this" {
  bucket = "dsm-s3-bucket-${var.name}"

  tags = {
    project = var.name
    type = var.type
  }
}
