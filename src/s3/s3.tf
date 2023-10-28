provider "aws" {
  region = "ap-south-1"
}

module "mys3" {
    source = "../modules/s3"   
    bucket_name = "pandugadu-bucket"
    environment = "dev"
    acl         = "private"
    

}
