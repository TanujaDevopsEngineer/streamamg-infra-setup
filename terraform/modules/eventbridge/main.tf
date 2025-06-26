resource "aws_cloudwatch_event_bus" "main" {
  name = "streamamg-bus"
}

output "bus_arn" {
  value = aws_cloudwatch_event_bus.main.arn
} 