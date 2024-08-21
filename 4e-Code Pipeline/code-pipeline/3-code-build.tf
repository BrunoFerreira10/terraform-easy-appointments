resource "aws_codebuild_project" "code_build_1" {
  name         = "code_build_1"
  description  = "Code build para aplicação ${var.GENERAL_TAG_SHORTNAME}"
  service_role = aws_iam_role.role_codebuild_1.arn

  artifacts {
    type      = "S3"
    location  = "your-s3-bucket-name"
    path      = "build-output"
    packaging = "ZIP"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:5.0"
    type         = "LINUX_CONTAINER"

    environment_variable {
      name  = "NODE_ENV"
      value = "production"
    }
  }

  source {
    type            = "GITHUB"
    location        = "https://github.com/your-repo-url.git"
    git_clone_depth = 1
  }

  build_timeout  = 30
  queued_timeout = 15

  logs_config {
    cloudwatch_logs {
      group_name  = "/aws/codebuild/php-nodejs-build"
      stream_name = "codebuild"
    }
  }

  tags = {
    Name = "PHPNodeJSBuildProject"
  }
}
