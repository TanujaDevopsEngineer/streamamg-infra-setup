resource "aws_ecr_repository" "main" {
  name = "streamamg-api"
}

output "repository_url" {
  value = aws_ecr_repository.main.repository_url
}