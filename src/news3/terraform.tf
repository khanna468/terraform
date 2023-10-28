terraform {
  backend "s3" {
    bucket = local.bucket
    region = "ap-south-1"
    key    = "terraform.tfstate"
    
  }
}

locals {
    bucket = module.mys3.bucket_id
}
provider "aws" {
    region = "ap-south-1"
  
}