resource "aws_db_subnet_group" "this_db_subnet" {
  name       = var.db_subnet_name
  subnet_ids = var.subnet_ids 
  tags = {
    Name = var.db_tag
    vpc_id = var.vpc_id
  }
}
resource "aws_db_instance" "this_rds_instance" {
  allocated_storage    = var.rds_instance.allocated_storage
  db_name              = var.rds_instance.db_name
  engine               = var.rds_instance.engine
  engine_version       = var.rds_instance.engine_version
  instance_class       = var.rds_instance.instance_class
  username             = var.rds_instance.username
  password             = var.rds_instance.password
  skip_final_snapshot  = var.rds_instance.skip_final_snapshot
  vpc_security_group_ids = var.rds_instance.vpc_security_group_ids
  db_subnet_group_name = var.db_subnet_name
}