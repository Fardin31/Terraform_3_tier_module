variable "alb" {
  type = object({
    name =  string
    load_balancer_type = string
    internal = bool
    security_groups = list(string)
    subnets = list(any) 
  })
}
variable "alb_tags" {
  type = string
}
//application lb target group
variable "application_lb_tg" {
  type = object({
    name = string
    port = number
    protocol = string
  })
}

// application tg attachment
variable "app_lb_tg_port" {
  type = number
}
variable "app_lb_vpc_id" {
  type = string
}
variable "web_target_id" {
  type = string
}