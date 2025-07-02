resource "aws_s3_bucket" "main" {
  bucket = "streamamg-video-content-${random_id.suffix.hex}"
  force_destroy = true
}

resource "random_id" "suffix" {
  byte_length = 4
}

output "bucket_name" {
  value = aws_s3_bucket.main.bucket
}

output "bucket_id" {
  value = aws_s3_bucket.main.id
}

output "bucket_domain_name" {
  value = aws_s3_bucket.main.bucket_regional_domain_name
}

output "bucket_arn" {
  value = aws_s3_bucket.main.arn
} 