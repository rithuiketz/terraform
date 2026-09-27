variable "AS" {
  
}

terraform {

  backend "s3" {
    bucket = "terrraform-backend-001"
    region = "us-east-2"
    key = "terraform.tfstate"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.0"
      
    }
  }
}

