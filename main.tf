provider "aws" {

  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
  region = "us-east-2"
}

provider "databricks" {
  host  = var.DATABRICKS_HOST
  token = var.DATABRICKS_TOKEN
}



module "aws_s3" {
  source = "./aws/s3"
}

module "aws_iam" {

  source        = "./aws/role"
  depends_on    = [module.aws_s3]
  S3_BUCKET_ARN = module.aws_s3.aws_bucket_arn
  S3_BUCKET_ID  = module.aws_s3.aws_bucket_id
}


module "dbx" {
  source   = "./dbx"
  iam_role = module.aws_iam.iam_role_arn

}









