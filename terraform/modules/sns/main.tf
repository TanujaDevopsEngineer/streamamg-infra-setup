resource "aws_sns_topic" "main" {
  name = "streamamg-topic"
}

output "topic_arn" {
  value = aws_sns_topic.main.arn
} 