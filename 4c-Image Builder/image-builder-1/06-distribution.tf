resource "aws_imagebuilder_distribution_configuration" "distribution-1" {
  name = "${var.shortname}-distribution-1"

  distribution {
    region = "us-east-1"
    ami_distribution_configuration {
      name = "${var.shortname}-{{imagebuilder:buildDate}}"
      ami_tags = {
        Name = "${var.shortname}-installation-ami"
      }
    }
  }
}

resource "aws_imagebuilder_distribution_configuration" "distribution-2" {
  name = "${var.shortname}-distribution-2"

  distribution {
    region = "us-east-1"
    ami_distribution_configuration {
      name = "${var.shortname}-{{imagebuilder:buildDate}}"
      ami_tags = {
        Name = "${var.shortname}-configuration-ami"
      }
    }
  }
}

resource "aws_imagebuilder_distribution_configuration" "distribution-3" {
  name = "${var.shortname}-distribution-3"

  distribution {
    region = "us-east-1"
    ami_distribution_configuration {
      name = "${var.shortname}-{{imagebuilder:buildDate}}"
      ami_tags = {
        Name = "${var.shortname}-application-ami"
      }
    }
  }
}