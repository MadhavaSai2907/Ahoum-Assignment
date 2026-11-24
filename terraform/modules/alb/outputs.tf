
output "alb_dns_name" {
  value = aws_lb.main.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.sessions.arn
}

output "listener_arn" {
  value = var.certificate_arn == null ? aws_lb_listener.http[0].arn : aws_lb_listener.https[0].arn
}

output "alb_arn_suffix" {
  value = aws_lb.main.arn_suffix
}