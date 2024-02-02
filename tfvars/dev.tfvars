//vpc
vpc_cidr_block = "10.0.0.0/16"
vpc_instance_tenancy = "default"
vpc_subnet_names       = ["public_subnet_1", "public_subnet_2", "private_subnet_1", "private_subnet_2"]
vpc_cidr_blocks        = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
vpc_availability_zones = ["us-east-1a", "us-east-1b", "us-east-1b", "us-east-1a"]
vpc_ig_name            = "INTERNET_GATEWAY"
vpc_eip_domain         = "vpc"
vpc_nat_ig_name        = "NAT_GATEWAY"
vpc_public_route_name  = "public"
vpc_private_route_name = "private"


vpc_route_table = {
  cidr_block = "0.0.0.0/0"
}

//ec2-key-pair
web_ssh_key_name = "web-ssh-key"
app_ssh_key_name =  "app-ssh-key"
web_ssh_key_path = "/root/.ssh/id_rsa.pub"
app_ssh_key_path = "/root/.ssh/id_rsa.pub"

//ec2-security-group
web_sg_name = "web-sg"
app_sg_name = "app-sg"
web_sg_ports = [80 , 443 , 22 , 0]
app_sg_ports = [80 , 22 , 3306 , 0]
# web_egress_sg_ports = [80 , 22 , 0]
# app_egress_sg_ports = [3306 ,0]
web_protocol = "tcp"
web-cidr-block = ["0.0.0.0/0"]
app_protocol = "tcp"
app-cidr-block = ["0.0.0.0/0"]
rds_sg_ports = [3306 ,0]
# rds_egress_sg_ports = [0]
rds_sg_name = "rds-sg"
alb_sg_ports = [443 , 80 ,0]
# alb_egress_sg_ports = [0 , 443]
alb_sg_name = "alb-sg"
rds-cidr-block = ["0.0.0.0/0"]
rds_protocol = "tcp"
alb-cidr-block = ["0.0.0.0/0"]
alb_protocol = "tcp"


//ec2-instance
web_ami = "ami-079db87dc4c10ac91"
web_instance_type = "t2.micro"
app_ami = "ami-079db87dc4c10ac91"
app_instance_type = "t2.micro"
web_tag = "WEB_INSTANCE"
app_tag = "APP_INSTANCE"
//rds_instance
rds_db_sub_name = "rds-db-subnet"
rds_db_tag = "rds-subnet"
rds_allocated_storage = 10
rds_db_name = "mydb"
rds_engine = "mysql"
rds_engine_version = "5.7"
rds_instance_class = "db.t2.micro"
rds_username = "admin"
rds_password = "fardin123"
rds_skip_final_snapshot = true

//aplication load balancer
//application Load balancer

 alb_name = "application-load-balancer"
 alb_load_balancer = "application"
 alb_internal = false
 tags_for_alb = "working"

//application lb target group

alb_tg = {
  alb_tg_name = "app-lb-tg"
  alb_tg_port = 80
  alb_tg_protocol = "HTTP"
}
application_lb_tg_port = 443
//s3_bucket & iam role
//bucket 
s3_bucket = "my-aws-bucket-898989"
s3_bucket_name = "my-aws-bucket-898989"
s3_bucket_env = "Dev"
// iam role
s3_iam_role_name = "s3_access_role"
 
s3_tag-key = "AmazonS3FullAccess"

//iam_instance_profile
iam_instance_profile_name = "s3_access_role"

//iam_role_policy
iam_role_policy_name = "s3_access_role"
