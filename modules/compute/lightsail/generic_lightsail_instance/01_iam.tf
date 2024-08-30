## --------------------------------------------------------------------------------------------------------------------
## Lightsail instance user
## --------------------------------------------------------------------------------------------------------------------
resource "aws_iam_user" "lightsail_instance" {
  name = "lightsail_instance"
}

# data "aws_iam_policy_document" "s3_read_policy" {
#   statement {
#     actions = [
#       "s3:GetObject",
#       "s3:ListBucket",
#     ]

#     resources = [
#       "arn:aws:s3:::${var.project_bucket_name}/code_deploy_outputs/build.zip"
#     ]

#     effect = "Allow"
#   }
# }

data "aws_iam_policy_document" "register_on_premises_instance" {
  statement {
    actions = [
      "codedeploy:RegisterOnPremisesInstance",
      "codedeploy:DeregisterOnPremisesInstance"
    ]

    resources = [
      "arn:aws:codedeploy:${var.region}:${data.aws_caller_identity.current.account_id}:instance:${aws_lightsail_instance.this.name}"
    ]

    effect = "Allow"
  }
}

# resource "aws_iam_policy" "read_s3_policy" {
#   name        = "${var.shortname}-read-only-s3-policy"
#   description = "Policy to allow read access to the specific S3 object"
#   policy      = data.aws_iam_policy_document.s3_read_policy.json
# }

resource "aws_iam_policy" "register_on_premises_instance" {
  name        = "${var.shortname}-register-on-premises-instance"
  description = "Permite registar intancia on-premises"
  policy      = data.aws_iam_policy_document.register_on_premises_instance.json
}

# resource "aws_iam_user_policy_attachment" "attach_policy" {
#   user       = aws_iam_user.lightsail_instance.name
#   policy_arn = aws_iam_policy.read_s3_policy.arn
# }

resource "aws_iam_user_policy_attachment" "lightsail_instance_attach_register_on_premises_instance" {
  user       = aws_iam_user.lightsail_instance.name
  policy_arn = aws_iam_policy.register_on_premises_instance.arn
}

resource "aws_iam_access_key" "lightsail_instance" {
  user = aws_iam_user.lightsail_instance.name
}