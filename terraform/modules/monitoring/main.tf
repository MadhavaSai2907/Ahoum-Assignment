resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "${var.project_name}-high-cpu"
  alarm_description   = "ECS CPU utilization is above 80%"
  comparison_operator = "GreaterThanThreshold"

  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 300
  statistic           = "Average"
  threshold           = 80

  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = var.ecs_service_name
  }
}


resource "aws_cloudwatch_metric_alarm" "high_5xx" {
  alarm_name          = "${var.project_name}-high-5xx"
  alarm_description   = "ALB HTTP 5xx errors reached threshold"
  comparison_operator = "GreaterThanOrEqualToThreshold"

  evaluation_periods = 1
  metric_name        = "HTTPCode_ELB_5XX_Count"
  namespace          = "AWS/ApplicationELB"
  period             = 300
  statistic          = "Sum"
  threshold          = 5

  dimensions = {
    LoadBalancer = var.alb_arn_suffix
  }
}
