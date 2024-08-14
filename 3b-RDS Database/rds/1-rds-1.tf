resource "aws_db_subnet_group" "subnet-group-rds-1" {
  name = "subnet-group-rds-${var.GENERAL_TAG_SHORTNAME}-1"
  subnet_ids = [
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-subnet-vpc-1-private-1a-id,
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-subnet-vpc-1-private-1b-id,
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-subnet-vpc-1-private-1c-id
  ]

  tags = {
    Name = "subnet-group-rds-${var.GENERAL_TAG_SHORTNAME}-1"
  }
}

resource "aws_db_instance" "rds-1" {

  db_name              = var.RDS_1_DB_NAME
  username             = var.RDS_1_DB_USERNAME
  password             = data.aws_ssm_parameter.RDS_1_DB_PASSWORD.value
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  parameter_group_name = "default.mysql8.0"
  db_subnet_group_name = aws_db_subnet_group.subnet-group-rds-1.name
  skip_final_snapshot  = true
  multi_az             = false

  vpc_security_group_ids = [
    data.terraform_remote_state.remote-state-vpc.outputs.vpcs-sg-vpc-1-rds-1-id
  ]

  tags = {
    Name = "rds-${var.GENERAL_TAG_SHORTNAME}-1"
  }
}