## --------------------------------------------------------------------------------------------------------------------
## Therefore, when you define aws_codebuild_source_credential, 
## aws_codebuild_project resource defined in the same module will use it.
## Note from this link: #
##     https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_source_credential.html
## Ao acicionar o recurso "aws_codebuild_source_credential" em algum modulo o(s) recurso(s) aws_codebuild_project
## vão automaticamente usá-lo para o acesso ao github.
## --------------------------------------------------------------------------------------------------------------------

resource "aws_codebuild_source_credential" "this" {
  ## Possible values
  ## https://awscli.amazonaws.com/v2/documentation/api/latest/reference/codebuild/import-source-credentials.html
  auth_type   = "CODECONNECTIONS"
  server_type = "GITHUB"
  token       = data.aws_codestarconnections_connection.github_app_connection.arn
}

data "aws_codestarconnections_connection" "github_app_connection" {
  name = "github_app_connection"
}

# resource "aws_codebuild_source_credential" "this" {
#   ## Possible values
#   ## https://awscli.amazonaws.com/v2/documentation/api/latest/reference/codebuild/import-source-credentials.html
#   auth_type   = "PERSONAL_ACCESS_TOKEN"
#   server_type = "GITHUB"
#   token       = data.aws_ssm_parameter.github_token.value
# }

## --------------------------------------------------------------------------------------------------------------------
## Webhooks - Qual evento no repositorio dispara o codebuild.
## --------------------------------------------------------------------------------------------------------------------
resource "aws_codebuild_webhook" "this" {
  project_name = aws_codebuild_project.this.name
  build_type   = "BUILD"
  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PUSH"
    }

    filter {
      type    = "HEAD_REF"
      pattern = "master"
    }
  }
}

## --------------------------------------------------------------------------------------------------------------------
## Code build project
## --------------------------------------------------------------------------------------------------------------------
resource "aws_codebuild_project" "this" {
  name         = "${var.codebuild_settings.project_name}"
  description  = "Code build para aplicação ${var.shortname}"
  service_role = aws_iam_role.codebuild.arn

  source {
    type            = "GITHUB"
    location        = var.app_repository_url_https // "https://github.com/your-repo-url.git"
    git_clone_depth = 1
    buildspec = templatefile("${path.module}/scripts/codebuild_spec.yml.tpl",{})
  }

  environment {
    type         = "LINUX_CONTAINER" 
    compute_type = "BUILD_GENERAL1_SMALL"
    # Check AWS Managed images:
    # aws codebuild list-curated-environment-images
    image        = "aws/codebuild/standard:7.0"
  }

  artifacts {
    type      = "S3"
    location  = var.project_bucket_name
    name      = "build.zip"
    path      = "code_deploy_outputs"
    packaging = "ZIP"
  }  

  build_timeout  = 30
  queued_timeout = 10

  logs_config {
    cloudwatch_logs {
      group_name  = "/aws/codebuild/${var.codebuild_settings.project_name}"
      stream_name = "codebuild_${var.codebuild_settings.project_name}"
    }
  }

  tags = {
    Name = "codebuild_${var.shortname}"
  }
}
