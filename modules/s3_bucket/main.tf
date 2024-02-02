//s3_bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket
  tags = {
    Name        = var.bucket_name
    Environment = var.env
  }
}



//iam role
resource "aws_iam_role" "s3_access_role" {
  name = var.s3_role_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = var.tag-key
  }
}
resource "aws_iam_instance_profile" "iam_instance_profile" {
  name = var.iam_instance_profile_name
  role = aws_iam_role.s3_access_role.id
}
resource "aws_iam_role_policy" "s3_access_policy" {
  name = var.aws_iam_role_policy_name
  role = aws_iam_role.s3_access_role.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:*",
          "s3-object-lambda:*"
        ],
        "Resource" : "*"
      }
    ]
  })
}