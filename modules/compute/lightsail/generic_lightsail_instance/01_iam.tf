## --------------------------------------------------------------------------------------------------------------------
## Lightsail instance user
## --------------------------------------------------------------------------------------------------------------------
resource "aws_iam_user" "lightsail_instance" {
  name = "lightsail_instance"
}

data "aws_iam_policy_document" "s3_read_policy" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::${var.project_bucket_name}/code_deploy_outputs/build.zip"
    ]

    effect = "Allow"
  }
}

resource "aws_iam_policy" "read_s3_policy" {
  name        = "read-only-s3-policy"
  description = "Policy to allow read access to the specific S3 object"
  policy      = data.aws_iam_policy_document.s3_read_policy.json
}

resource "aws_iam_user_policy_attachment" "attach_policy" {
  user       = aws_iam_user.lightsail_instance.name
  policy_arn = aws_iam_policy.read_s3_policy.arn
}

resource "aws_iam_access_key" "lightsail_instance" {
  user = aws_iam_user.lightsail_instance.name
}