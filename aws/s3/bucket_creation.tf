resource "aws_s3_bucket" "tf_creation_bucket" {
    tags = {
      "name" = "rith-tf-bucket"
    }
  
}