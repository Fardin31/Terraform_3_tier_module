resource "aws_lb" "this_alb" {
  name               = var.alb.name
  internal           = var.alb.internal
  load_balancer_type = var.alb.load_balancer_type
  security_groups    = var.alb.security_groups
  subnets            = var.alb.subnets
  tags = {
    Environment = var.alb_tags
  }
}
resource "aws_lb_target_group" "app_lb_tg" {
  name     = var.application_lb_tg.name
  port     = var.application_lb_tg.port
  protocol = var.application_lb_tg.protocol
  vpc_id   = var.app_lb_vpc_id
}

resource "aws_lb_target_group_attachment" "web_tg" {
  target_group_arn = aws_lb_target_group.app_lb_tg.id
  target_id        = var.web_target_id
  port             = var.app_lb_tg_port
}