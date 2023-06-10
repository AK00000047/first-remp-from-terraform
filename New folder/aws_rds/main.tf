resource "aws_db_instance" "myinstance" {
  engine               = var.engine
  identifier           = var.identifier
  allocated_storage    = var.storage_size
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  vpc_security_group_ids = [var.vpc_security_group_ids]
  db_subnet_group_name  = var.db_subnet_group_name
  availability_zone = var.availability_zone
  skip_final_snapshot  = true
  publicly_accessible =  true
}