resource "aws_sqs_queue" "main" {
  name = "streamamg-queue"
}

output "queue_url" {
  value = aws_sqs_queue.main.url
} 