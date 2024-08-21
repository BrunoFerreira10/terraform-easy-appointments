resource "aws_imagebuilder_workflow" "build" {
  name    = "workflow_build_${var.shortname}"
  version = "1.0.0"
  type    = "BUILD"

  lifecycle {
    ignore_changes = [data]
  }

  data = templatefile("${path.module}/workflows/workflow_build.tpl", {
  })

  tags = {
    Name = "workflow_build_${var.shortname}"
  }
}