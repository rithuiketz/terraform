variable "credential_name" {
  type        = string
  description = "Name of the Databricks storage credential"
}

variable "role_arn" {
  type        = string
  description = "IAM Role ARN to associate with the credential"
}

variable "s3_bucket_name" {
  type        = string
  default = "east-us"
  description = "S3 bucket name for external location"
}