resource "aws_codebuild_project" "this" {
  name         = "codebuild_${var.shortname}"
  description  = "Code build para aplicação ${var.shortname}"
  service_role = aws_iam_role.codebuild.arn

  artifacts {
    type      = "S3"
    location  = var.project_bucket_name
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
