resource "aws_cloudwatch_log_group" "ecs" {
  name = "/ecs/${var.ecs_cluster_name}"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "lambda" {
  name = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = 7
}

resource "aws_cloudwatch_metric_alarm" "ecs_high_cpu" {
  alarm_name          = "ECSHighCPUUtilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "ECS CPU utilization is high."
  dimensions = {
    ClusterName = var.ecs_cluster_name
  }
}

output "ecs_high_cpu_alarm_arn" {
  value = aws_cloudwatch_metric_alarm.ecs_high_cpu.arn
} 