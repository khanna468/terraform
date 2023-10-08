terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = ">= 3.1.0"
    }
  }

  backend "s3" {
    bucket = "terraform-bucket12"
    key    = "assignment/main-state"
    region = "ap-south-1"
    
  }
}

provider "aws" {
  alias = "ap-south-1"
  region = "ap-south-1"
}

provider "aws" {
  alias = "us-east-1"
  region = "us-east-1"
}
