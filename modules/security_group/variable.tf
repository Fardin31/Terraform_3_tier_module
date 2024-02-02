variable "sg_name" {
  type = string
}
variable "sg_ports" {
  type = list(any)
}
variable "vpc_id" {
  type = string
}
variable "protocol" {
  type = string
}
variable "cidr-blocks" {
  type = list(string)
}
# variable "egress_sg_ports" {
#   type = list(any)
# }

