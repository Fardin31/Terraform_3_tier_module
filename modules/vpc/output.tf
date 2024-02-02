output "this_vpc_id" {
  value = aws_vpc.this_aws_3_tier.id
}
output "this_subnet_id_01" {
  value = aws_subnet.this_aws_subnet[0].id
}
output "this_subnet_id_02" {
  value = aws_subnet.this_aws_subnet[1].id
}
output "this_subnet_id_03" {
  value = aws_subnet.this_aws_subnet[2].id
}
output "this_subnet_id_04" {
  value = aws_subnet.this_aws_subnet[3].id
}