resource "aws_imagebuilder_distribution_configuration" "distribution-1" {
  name = "${var.shortname}-distribution-1"

  distribution {
    region = "us-east-1"
    ami_distribution_configuration {
      name = "${var.shortname}-distro-version-{{imagebuilder:buildDate}}"
      ami_tags = {
        Name = "${var.shortname}-distro-version-{{imagebuilder:buildVersion}}"
      }
    }
  }


}