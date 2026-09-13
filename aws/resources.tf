data "aws_caller_identity" "current" {}

# 1. S3 Bucket
resource "aws_s3_bucket" "this" {
  bucket        = var.s3_bucket_name
  force_destroy = false
}

# 2. S3 Permissions Policy
resource "aws_iam_policy" "this" {
  name        = "${var.role_name}-policy"
  description = "IAM policy for Databricks S3 access"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket",
          "s3:GetBucketLocation"
        ]
        Resource = [
          aws_s3_bucket.this.arn,
          "${aws_s3_bucket.this.arn}/*"
        ]
      }
    ]
  })
}

# 3. Trust Policy data source from Databricks provider
data "databricks_aws_unity_catalog_assume_role_policy" "this" {
  aws_account_id = data.aws_caller_identity.current.account_id
  role_name      = var.role_name
  external_id    = var.external_id
}

# 4. IAM Role using the Trust Policy
resource "aws_iam_role" "this" {
  name               = var.role_name
  assume_role_policy = data.databricks_aws_unity_catalog_assume_role_policy.this.json
}

# 5. Attach S3 Policy to IAM Role
resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.this.arn
}