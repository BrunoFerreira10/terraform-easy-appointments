## --------------------------------------------------------------------------------------------------------------------
## Codeduild Policies
## --------------------------------------------------------------------------------------------------------------------
resource "aws_iam_policy" "base" {
  name = "CodeBuildBasePolicy-${var.codebuild_settings.project_name}-${var.region}"
  path = "/TerraforManaged"
  description = "Policy used in trust relationship with CodeBuild and ${var.shortname} application"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Resource" : [
          "arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/${var.codebuild_settings.project_name}",
          "arn:aws:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/codebuild/${var.codebuild_settings.project_name}:*"
        ],
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
      },
      # {
      #   "Effect" : "Allow",
      #   "Resource" : [
      #     "arn:aws:s3:::codepipeline-us-east-1-*"
      #   ],
      #   "Action" : [
      #     "s3:PutObject",
      #     "s3:GetObject",
      #     "s3:GetObjectVersion",
      #     "s3:GetBucketAcl",
      #     "s3:GetBucketLocation"
      #   ]
      # },
      # {
      #   "Effect" : "Allow",
      #   "Resource" : [
      #     "arn:aws:s3:::brunoferreira86dev-easy-appointments-logging",
      #     "arn:aws:s3:::brunoferreira86dev-easy-appointments-logging/*"
      #   ],
      #   "Action" : [
      #     "s3:PutObject",
      #     "s3:GetObject",
      #     "s3:GetBucketAcl",
      #     "s3:GetBucketLocation",
      #     "s3:ListBucket"
      #   ]
      # },
      {
        "Effect" : "Allow",
        "Action" : [
          "codebuild:CreateReportGroup",
          "codebuild:CreateReport",
          "codebuild:UpdateReport",
          "codebuild:BatchPutTestCases",
          "codebuild:BatchPutCodeCoverages"
        ],
        "Resource" : [
          "arn:aws:codebuild:us-east-1:339712924273:report-group/${var.codebuild_settings.project_name}-*"
        ]
      }
    ]
  })
}


## CodeBuildCodeConnectionsSourceCredentialsPolicy-TesteBuild-us-east-1
## Policy used in trust relationship with CodeBuild
resource "aws_iam_policy" "connections" {
  name = "CodeBuildCodeConnectionsSourceCredentialsPolicy-${var.codebuild_settings.project_name}-${var.region}"
  path = "/TerraforManaged"
  description = "Policy used in trust relationship with CodeBuild and ${var.shortname} application"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect" : "Allow",
        "Action" : [
          "codestar-connections:GetConnectionToken",
          "codestar-connections:GetConnection",
          "codeconnections:GetConnectionToken",
          "codeconnections:GetConnection"
        ],
        "Resource" : [
          "arn:aws:codestar-connections:us-east-1:339712924273:connection/48875c7b-6fdb-45e6-9bb2-74bd01d296d9",
          "arn:aws:codeconnections:us-east-1:339712924273:connection/48875c7b-6fdb-45e6-9bb2-74bd01d296d9"
        ]
      }
    ]
  })
}



##CodeBuildSecretsManagerSourceCredentialsPolicy-TesteBuild-us-east-1
## Policy used in trust relationship with CodeBuild
# resource "aws_iam_policy" "secret_manager" {
#   name = "CodeBuildSecretsManagerSourceCredentialsPolicy-${var.codebuild_settings.project_name}-${var.region}"
#   path = "/TerraforManaged"
#   description = "Policy used in trust relationship with CodeBuild and ${var.shortname} application"

#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         "Sid" : "SidGetSecretValue",
#         "Effect" : "Allow",
#         "Action" : [
#           "secretsmanager:GetSecretValue"
#         ],
#         "Resource" : [
#           "arn:aws:secretsmanager:us-east-1:339712924273:secret:SECRET_AWS_SERVICES_TOKEN-kZVQ62"
#         ]
#       }
#     ]
#   })
# }


resource "aws_iam_role" "codebuild" {
  name = "codebuild-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "codebuild.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "codebuild_attach_base" {
  role       = aws_iam_role.codebuild.name
  policy_arn = aws_iam_policy.base.arn
}

resource "aws_iam_role_policy_attachment" "codebuild_attach_connections" {
  role       = aws_iam_role.codebuild.name
  policy_arn = aws_iam_policy.connections.arn
}

# resource "aws_iam_role_policy_attachment" "codebuild_attach_secrets" {
#   role       = aws_iam_role.codebuild.name
#   policy_arn = aws_iam_policy.secret_manager.arn
# }

# resource "aws_iam_role_policy_attachment" "codebuild_attach_developer_access" {
#   role       = aws_iam_role.codebuild.name
#   policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess"
# }
