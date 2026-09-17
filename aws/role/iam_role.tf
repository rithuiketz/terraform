# 1. Add this block at the top to automatically manage the External ID with Databricks
terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
    }
  }
}

data "databricks_aws_assume_role_policy" "this" {
  external_id = "rith-unique-storage-id"
}

# 2. Updated your role to use the automated trust policy JSON
resource "aws_iam_role" "iam_tf_role" {
  name               = "rith-tf-role"
  assume_role_policy = data.databricks_aws_assume_role_policy.this.json
}

# 3. Your existing IAM Policy (Kept exactly as it was)
resource "aws_iam_policy" "iam_s3_policy" {
  name        = "rith-tf-s3-policy"
  description = "Allows IAM role to access the S3 bucket"
  depends_on  = [aws_iam_role.iam_tf_role]
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ]
        Resource = [
          "${var.S3_BUCKET_ARN}",
          "${var.S3_BUCKET_ARN}/*"
        ]
      }
    ]
  })
}

# 4. Your existing Policy Attachment (Kept exactly as it was)
resource "aws_iam_role_policy_attachment" "policy_attachment" {
  depends_on = [aws_iam_policy.iam_s3_policy]
  role       = aws_iam_role.iam_tf_role.name
  policy_arn = aws_iam_policy.iam_s3_policy.arn 
}
