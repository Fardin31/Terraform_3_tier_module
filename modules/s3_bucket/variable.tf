//bucket
variable "bucket" {
  type = string
  }
 variable "bucket_name" {
   type = string
 }
 variable "env" {
   type = string
 }

// iam role
variable "s3_role_name" {
    type = string
}
variable "tag-key" {
  type = string
}

//instance_profile
variable "iam_instance_profile_name" {
  type = string
}

// iam_role_policy
variable "aws_iam_role_policy_name" {
  type = string
}