module "mys31" {
    source = "../modules/s3"   
    bucket_name = "pandugadu234-bucket"
    environment = "dev"
    acl         = "private"
    

}