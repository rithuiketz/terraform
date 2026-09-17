output "aws_bucket_arn" {
  value = aws_s3_bucket.tf_creation_bucket.arn
}
output "aws_bucket_id" {
  value = aws_s3_bucket.tf_creation_bucket.id
}