variable "ami" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "key_name" {
  type = string
}
variable "security_group" {
  type = string
}
variable "subnet_id" {
  type = string
}
variable "iam_instance_profile" {
  type = string
}
variable "tags" {
  type = string
}
variable "associate_public_ip_address" {
  type = bool
}
