terraform {
  backend "s3" {
    bucket = module.mys3.bucket_id
    region = "ap-south-1"
    key    = "terraform.tfstate"
    
  }
}

provider "aws" {
    region = "ap-south-1"
  
}