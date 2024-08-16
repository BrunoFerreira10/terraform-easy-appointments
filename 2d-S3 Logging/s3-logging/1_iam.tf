# resource "aws_iam_policy" "imagebuilder_logs_policy" {
#   name        = "ImageBuilderLogsToS3Policy"
#   description = "Permite que Image Builder escreva logs no bucket S3."

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Sid       = "ImageBuilderLogsToS3",
#         Effect    = "Allow",
#         Action    = "s3:PutObject",
#         Resource  = "arn:aws:s3:::${aws_s3_bucket.s3-logging-1.id}/imagebuilder/*",
#         Condition = {
#           StringEquals = {
#             "aws:SourceAccount" = var.account_id
#           }
#         }
#       }
#     ]
#   })
# }

# resource "aws_iam_role" "imagebuilder_logs_role" {
#   name = "ImageBuilderLogsToS3Role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect    = "Allow",
#         Principal = {
#           Service = "imagebuilder.amazonaws.com"
#         },
#         Action = "sts:AssumeRole"
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "attach_imagebuilder_policy" {
#   role       = aws_iam_role.imagebuilder_logs_role.name
#   policy_arn = aws_iam_policy.imagebuilder_logs_policy.arn
# }



# resource "aws_iam_policy" "cloudwatch_logs_policy" {
#   name        = "CloudWatchLogsToS3Policy"
#   description = "Permite que CloudWatch Logs escreva no bucket S3."

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Sid       = "CloudWatchLogsToS3",
#         Effect    = "Allow",
#         Action    = "s3:PutObject",
#         Resource  = "arn:aws:s3:::${aws_s3_bucket.s3-logging-1.id}/cloudwatch/*",
#         Condition = {
#           StringEquals = {
#             "aws:SourceAccount" = var.account_id
#           },
#           ArnLike = {
#             "aws:SourceArn" = "arn:aws:logs:${var.region}:${var.account_id}:log-group/*"
#           }
#         }
#       }
#     ]
#   })
# }

# resource "aws_iam_role" "cloudwatch_logs_role" {
#   name = "CloudWatchLogsToS3Role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect    = "Allow",
#         Principal = {
#           Service = "logs.${var.region}.amazonaws.com"
#         },
#         Action = "sts:AssumeRole"
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "attach_cloudwatch_policy" {
#   role       = aws_iam_role.cloudwatch_logs_role.name
#   policy_arn = aws_iam_policy.cloudwatch_logs_policy.arn
# }

