data "aws_caller_identity" "current" {}

# Step 1: Create Databricks Storage Credential (Bucket not needed yet!)
resource "databricks_storage_credential" "external" {
  name = "${var.s3_bucket_name}-credential"
  aws_iam_role {
    role_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${var.role_name}"
  }
}

# Step 2: Create AWS S3 Bucket and IAM Role using external_id from Step 1
module "aws_s3_role" {
  source         = "./modules/aws_s3_role"
  s3_bucket_name = var.s3_bucket_name
  role_name      = var.role_name
  external_id    = databricks_storage_credential.external.aws_iam_role[0].external_id
}

# Step 3: Create Databricks External Location (Only AFTER S3 bucket & IAM role exist)
resource "databricks_external_location" "this" {
  name            = "Rithuik-location"
  url             = "s3://${module.aws_s3_role.bucket_name}"
  credential_name = databricks_storage_credential.external.id
  comment         = "External location managed by Terraform"

  # Explicit dependency ensures S3 bucket and IAM policy are fully applied first
  depends_on = [module.aws_s3_role]
}