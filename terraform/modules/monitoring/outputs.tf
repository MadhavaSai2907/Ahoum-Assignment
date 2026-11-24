output "cpu_alarm_name" {
  value = aws_cloudwatch_metric_alarm.high_cpu.alarm_name
}

output "http_5xx_alarm_name" {
  value = aws_cloudwatch_metric_alarm.high_5xx.alarm_name
}
