resource "aws_s3_bucket" "s3-remote-state" {
  bucket = var.GENERAL_REMOTE_STATE_BUCKET
}

resource "aws_s3_bucket_versioning" "versionamento-s3-remote-state" {
  bucket = aws_s3_bucket.s3-remote-state.id

  versioning_configuration {
    status = "Enabled"
  }
}