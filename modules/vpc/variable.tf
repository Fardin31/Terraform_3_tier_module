variable "aws_vpc" {
  type = object({
    cidr_block       = string,
    instance_tenancy = string,
  })
}
variable "vpc_tags" {
  type = map(string)
  default = {
    Name = "my-vpc"
  }
}
variable "subnet_names" {
  type = list(string)
}

variable "cidr_blocks" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}
variable "ig_name" {
  type = string
}
variable "eip_domain" {
  type = string
}
variable "nat_ig_name" {
  type = string
}
variable "public_route_name" {
  type = string
}
variable "private_route_name" {
  type = string
}
variable "route_table" {
  type = object({
    cidr_block = string
  })
}
variable "public_subnet_indices" {
  type    = list(number)
  default = [0, 1]
}

variable "private_subnet_indices" {
  type    = list(number)
  default = [2, 3]
}
variable "nat_subnet_id" {
  type = string
}