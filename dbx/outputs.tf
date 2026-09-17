output "databricks_external_id" {
  value = databricks_storage_credential.tf_dbx_cred.aws_iam_role[0].external_id
}