# 1. Storage Credential (generates External ID)
resource "databricks_storage_credential" "external" {
  name = var.credential_name
  aws_iam_role {
    role_arn = var.role_arn
  }
}

# 2. External Location linking S3 path to Credential
resource "databricks_external_location" "this" {
  name            = "${var.credential_name}-location"
  url             = "s3://${var.s3_bucket_name}"
  credential_name = databricks_storage_credential.external.id
  comment         = "External location managed by Terraform"
}