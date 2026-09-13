variable "aws_access_key" {
    type = string
    description = "AWS_ACCE_KEY"
  
}

variable "aws_secret_key" {
    type = string
    description = "AWS_SECRET_KEY"
  
}

variable "s3_bucket_name" {
  type        = string
  description = "Name of the S3 bucket to create"
}

variable "role_name" {
  type        = string
  description = "Name of the IAM role to create"
}

variable "external_id" {
  type        = string
  description = "Databricks Storage Credential External ID for trust condition"
}