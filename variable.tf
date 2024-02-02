//vpc
variable "vpc_cidr_block" {
  type = string
}
variable "vpc_instance_tenancy" {
  type = string
}
variable "vpc_tags" {
  type = map(string)
  default = {
    Name = "my-vpc"
  }
}
variable "vpc_subnet_names" {
  type = list(string)
}

variable "vpc_cidr_blocks" {
  type = list(string)
}

variable "vpc_availability_zones" {
  type = list(string)
}
variable "vpc_ig_name" {
  type = string
}
variable "vpc_eip_domain" {
  type = string
}
variable "vpc_nat_ig_name" {
  type = string
}
variable "vpc_public_route_name" {
  type = string
}
variable "vpc_private_route_name" {
  type = string
}
variable "vpc_route_table" {
  type = object({
    cidr_block = string
  })
}
variable "vpc_public_subnet_indices" {
  type    = list(number)
  default = [0, 1]
}

variable "vpc_private_subnet_indices" {
  type    = list(number)
  default = [2, 3]
}
//ec2-key-pair 
variable "web_ssh_key_name" {
  type = string
}
variable "app_ssh_key_name" {
  type = string
}
variable "web_ssh_key_path" {
  type = string
}
variable "app_ssh_key_path" {
  type = string
}
//ec2-security-group
variable "web_sg_name" {
  type = string
}
variable "app_sg_name" {
  type = string
}
variable "web_sg_ports" {
  type = list(any)
}
variable "app_sg_ports" {
  type = list(any)
}
# variable "web_egress_sg_ports" {
#   type = list(any)
# }
# variable "app_egress_sg_ports" {
#   type = list(any)
# }
variable "web_protocol" {
  type = string
}

variable "web-cidr-block" {
  type = list(string)
}
variable "app_protocol" {
  type = string
}
variable "app-cidr-block" {
  type = list(string)
}
variable "rds_sg_name" {
  type = string
}
variable "rds_sg_ports" {
  type = list(any)
}
# variable "rds_egress_sg_ports" {
#   type = list(any)
# }
variable "alb_sg_ports" {
  type = list(any)
}
# variable "alb_egress_sg_ports" {
#   type = list(any)
# }
variable "alb_sg_name" {
  type = string
}
variable "rds_protocol" {
  type = string
}
variable "rds-cidr-block" {
  type = list(string)
}
variable "alb_protocol" {
  type = string
}
variable "alb-cidr-block" {
  type = list(string)
}

//ec2_instance
variable "web_ami" {
  type = string
}
variable "web_instance_type" {
  type = string
}
variable "app_ami" {
  type = string
}
variable "app_instance_type" {
  type = string
}
variable "web_tag" {
  type = string
}
variable "app_tag" {
  type = string
}
//rds_instance
variable "rds_db_sub_name" {
  type = string
}
variable "rds_db_tag" {
  type = string
}
variable "rds_allocated_storage" {
  type = number
}
variable "rds_db_name" {
  type = string
}
variable "rds_engine" {
  type = string
}
variable "rds_engine_version" {
  type = string
}
variable "rds_instance_class" {
  type = string
}
variable "rds_username" {
  type = string
}
variable "rds_password" {
  type = string
}
variable "rds_skip_final_snapshot" {
  type = bool
}
//aplication load balancer
variable "alb_name" {
  type = string
}
variable "alb_load_balancer" {
  type = string
}
variable "alb_internal" {
  type = bool
}
variable "tags_for_alb" {
  type = string
}
variable "alb_tg" {
  type = object({
    alb_tg_name     = string
    alb_tg_port     = number
    alb_tg_protocol = string
  })
}
variable "application_lb_tg_port" {
  type = string
}
//s3_bucket & iam role
//bucket
variable "s3_bucket" {
  type = string
}
variable "s3_bucket_name" {
  type = string
}
variable "s3_bucket_env" {
  type = string
}
// iam role
variable "s3_iam_role_name" {
  type = string
}
variable "s3_tag-key" {
  type = string
}

//instance_profile
variable "iam_instance_profile_name" {
  type = string
}

// iam_role_policy
variable "iam_role_policy_name" {
  type = string
}



