data "aws_ssm_parameter" "my_ip" {
  name = "/github_secrets/general_my_ip"
}