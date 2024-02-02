variable "db_subnet_name" {
  type = string
}
variable "db_tag" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "subnet_ids" {
  type = list(any)
}

variable "rds_instance" {
  type = object({
     allocated_storage = number
     db_name = string
     engine = string
     engine_version = string
     instance_class = string
     username = string
     password = string
     skip_final_snapshot = bool
     vpc_security_group_ids = list(string)
     db_subnet_name = string
  })
}