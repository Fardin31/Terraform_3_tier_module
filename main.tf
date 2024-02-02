//vpc
module "aws_3_tier_vpc" {
  source = "./modules/vpc"
  aws_vpc = {
    cidr_block       = var.vpc_cidr_block
    instance_tenancy = var.vpc_instance_tenancy
  }
  subnet_names           = var.vpc_subnet_names
  cidr_blocks            = var.vpc_cidr_blocks
  availability_zones     = var.vpc_availability_zones
  ig_name                = var.vpc_ig_name
  eip_domain             = var.vpc_eip_domain
  nat_ig_name            = var.vpc_nat_ig_name
  public_route_name      = var.vpc_public_route_name
  private_route_name     = var.vpc_private_route_name
  route_table            = var.vpc_route_table
  private_subnet_indices = var.vpc_private_subnet_indices
  public_subnet_indices  = var.vpc_public_subnet_indices
  nat_subnet_id =  module.aws_3_tier_vpc.this_subnet_id_01
}

//key_pair
module "web_ssh_key_pair" {
  source     = "./modules/ssh_key"
  key_name   = var.web_ssh_key_name
  public_key = var.web_ssh_key_path
}

module "app_ssh_key_pair" {
  source     = "./modules/ssh_key"
  key_name   = var.app_ssh_key_name
  public_key = var.app_ssh_key_path
}
//ec2-security-group

module "web_security_group" {
  source      = "./modules/security_group"
  sg_name     = var.web_sg_name
  vpc_id      = module.aws_3_tier_vpc.this_vpc_id
  sg_ports    = var.web_sg_ports
  protocol    = var.web_protocol
  cidr-blocks = var.web-cidr-block
  #egress_sg_ports = var.web_egress_sg_ports
  
}

module "app_security_group" {
  source      = "./modules/security_group"
  sg_name     = var.app_sg_name
  vpc_id      = module.aws_3_tier_vpc.this_vpc_id
  sg_ports    = var.app_sg_ports
  protocol    = var.app_protocol
  cidr-blocks = var.app-cidr-block
  #egress_sg_ports = var.app_egress_sg_ports
  
}
module "rds_security_group" {
  source      = "./modules/security_group"
  sg_name     = var.rds_sg_name
  vpc_id      = module.aws_3_tier_vpc.this_vpc_id
  sg_ports    = var.rds_sg_ports
  protocol    = var.rds_protocol
  cidr-blocks = var.rds-cidr-block
  #egress_sg_ports = var.rds_egress_sg_ports
 
}
module "alb_security_group" {
  source      = "./modules/security_group"
  sg_name     = var.alb_sg_name
  vpc_id      = module.aws_3_tier_vpc.this_vpc_id
  sg_ports    = var.alb_sg_ports
  protocol    = var.alb_protocol
  cidr-blocks = var.alb-cidr-block
  #egress_sg_ports = var.alb_egress_sg_ports
  
}
//ec2-instance
module "web_ec2_instance" {
  source               = "./modules/ec2_instance"
  ami                  = var.web_ami
  instance_type        = var.web_instance_type
  key_name             = module.web_ssh_key_pair.this_ssh_key
  security_group       = module.web_security_group.security_group_id
  subnet_id            = module.aws_3_tier_vpc.this_subnet_id_01
  iam_instance_profile = module.s3_bucket.iam_instance_profile_name
  associate_public_ip_address = true
  tags = var.web_tag

}
module "app_ec2_instance" {
  source               = "./modules/ec2_instance"
  ami                  = var.app_ami
  instance_type        = var.web_instance_type
  key_name             = module.app_ssh_key_pair.this_ssh_key
  security_group       = module.app_security_group.security_group_id
  subnet_id            = module.aws_3_tier_vpc.this_subnet_id_03
  iam_instance_profile = module.s3_bucket.iam_instance_profile_name
  associate_public_ip_address = false
  tags = var.app_tag
}

//rds-instance
module "rds_db_instance" {
  source         = "./modules/RDS"
  db_subnet_name = var.rds_db_sub_name
  db_tag         = var.rds_db_tag
  vpc_id         = module.aws_3_tier_vpc.this_vpc_id
  subnet_ids     = [module.aws_3_tier_vpc.this_subnet_id_03, module.aws_3_tier_vpc.this_subnet_id_04]
  rds_instance = {
    allocated_storage      = var.rds_allocated_storage
    db_name                = var.rds_db_name
    engine                 = var.rds_engine
    engine_version         = var.rds_engine_version
    instance_class         = var.rds_instance_class
    username               = var.rds_username
    password               = var.rds_password
    skip_final_snapshot    = var.rds_skip_final_snapshot
    vpc_security_group_ids = [module.rds_security_group.security_group_id, module.app_security_group.security_group_id]
    db_subnet_name = module.rds_db_instance.db_subnet_group_name
  }
}
//Aplication_load_balancer
module "Application_load_balancer" {
  source = "./modules/Application_load_balancer"
  alb = {
    name               = var.alb_name
    load_balancer_type = var.alb_load_balancer
    internal           = var.alb_internal
    security_groups    = [module.alb_security_group.security_group_id]
    subnets            = [module.aws_3_tier_vpc.this_subnet_id_01, module.aws_3_tier_vpc.this_subnet_id_02]
  }
  alb_tags = var.tags_for_alb
  application_lb_tg = {
    name     = var.alb_tg.alb_tg_name
    port     = var.alb_tg.alb_tg_port
    protocol = var.alb_tg.alb_tg_protocol
  }
  app_lb_tg_port = var.application_lb_tg_port
  app_lb_vpc_id  = module.aws_3_tier_vpc.this_vpc_id
  web_target_id  = module.web_ec2_instance.instance_id
}
//s3_bucket & iam role
module "s3_bucket" {
  source                    = "./modules/s3_bucket"
  bucket                    = var.s3_bucket
  bucket_name               = var.s3_bucket_name
  env                       = var.s3_bucket_env
  s3_role_name              = var.s3_iam_role_name
  tag-key                   = var.s3_tag-key
  iam_instance_profile_name = var.iam_instance_profile_name
  aws_iam_role_policy_name  = var.iam_role_policy_name
}