resource "aws_vpc_endpoint" "s3" {
  vpc_id            = var.vpc.id
  service_name      = "com.amazonaws.${var.region}.s3"

  route_table_ids = var.vpc.route_tables.private.id

  tags = {
    Name = "s3_${var.shortname}"
  }
}

