resource "aws_security_group" "this_sg" {
  name   = var.sg_name
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "this_ingress_sg" {
  count             = length(var.sg_ports)
  type              = "ingress"
  from_port         = var.sg_ports[count.index]
  to_port           = var.sg_ports[count.index]
  protocol          = var.protocol
  cidr_blocks       = var.cidr-blocks
  security_group_id = aws_security_group.this_sg.id
}
resource "aws_security_group_rule" "this_egress_sg" {
  # count             = length(var.egress_sg_ports)
  type              = "egress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  cidr_blocks       = var.cidr-blocks
  security_group_id = aws_security_group.this_sg.id
}
