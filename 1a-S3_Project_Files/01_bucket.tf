resource "aws_s3_bucket" "project_files" {
  bucket = var.GENERAL_PROJECT_BUCKET
}

# resource "aws_s3_bucket_versioning" "project_files" {
#   bucket = aws_s3_bucket.project_files.id

#   versioning_configuration {
#     status = "Enabled"
#   }
# }