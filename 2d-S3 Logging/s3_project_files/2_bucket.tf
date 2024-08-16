resource "aws_s3_bucket" "s3-logging-1" {
  bucket        = var.S3_LOGGING_BUCKET_NAME
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "s3-logging-1" {
  bucket = aws_s3_bucket.s3-logging-1.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  depends_on = [
    aws_s3_bucket.s3-logging-1
  ]
}
