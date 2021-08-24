output "lb_target_group_arn" {
  value = aws_lb_target_group.beautiful_tg.arn
}

output "lb_endpoint" {
  value = aws_lb.beautiful_lb.dns_name
}