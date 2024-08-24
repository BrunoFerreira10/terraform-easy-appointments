module "data" {
  source = "../modules/data"
  requested_data = []
}

data "aws_codestarconnections_connection" "github_app_connection" {
  name = "github_app_connection"
}