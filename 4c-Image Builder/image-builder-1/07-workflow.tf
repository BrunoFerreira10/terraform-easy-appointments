resource "aws_imagebuilder_workflow" "img-builder-workflow-1" {
  name    = "img-builder-workflow-1"
  version = "1.0.0"
  type    = "BUILD"

  data = templatefile("${path.module}/workflows/workflow-1.tpl", {
  })
}