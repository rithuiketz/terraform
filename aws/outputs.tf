output "role_arn" {
  value       = aws_iam_role.this.arn
  description = "ARN of the created IAM Role"
}

output "bucket_name" {
  value       = aws_s3_bucket.this.id
  description = "Name of the created S3 bucket"
}
