output "github_vars" {
  description = "All Gihub variables values."
  value = nonsensitive(local.github_vars)
}