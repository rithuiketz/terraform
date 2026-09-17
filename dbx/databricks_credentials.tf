terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
    }
  }
}
resource "databricks_storage_credential" "tf_dbx_cred" {
  name = "testing"

  aws_iam_role {
    role_arn = var.iam_role
  }
}
