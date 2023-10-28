module "mys31" {
    source = "../modules/s3"   
    bucket_name = "pandugadu234-bucket"
    environment = "dev"
    acl         = "private"
    export_name = module.mys3.bucket_id
        
    }

}