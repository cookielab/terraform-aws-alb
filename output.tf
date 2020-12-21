output "lb_arn" {
  value = aws_lb.main.arn
}

output "lb_https_arn" {
  value = aws_lb_listener.main_https.arn
}
