resource "aws_imagebuilder_distribution_configuration" "installation" {
  name = "distribution_installation_${var.shortname}"

  distribution {
    region = var.region
    ami_distribution_configuration {
      name = "ami_${var.shortname}_{{imagebuilder:buildDate}}"
      ami_tags = {
        Name = "ami_${var.shortname}_{{imagebuilder:buildDate}}"
      }
    }
  }
}

resource "aws_imagebuilder_distribution_configuration" "application" {
  name = "distribution_application_${var.shortname}"

  distribution {
    region = var.region
    ami_distribution_configuration {
      name = "ami_${var.shortname}_{{imagebuilder:buildDate}}"
      ami_tags = {
        Name = "ami_${var.shortname}_{{imagebuilder:buildDate}}"
      }
    }
  }
}