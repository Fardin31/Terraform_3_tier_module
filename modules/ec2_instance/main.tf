resource "aws_instance" "this_ec2_instnace" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [var.security_group]
  subnet_id              = var.subnet_id
  iam_instance_profile = var.iam_instance_profile
  associate_public_ip_address = var.associate_public_ip_address
  tags = {
    Name = var.tags
  }
}

