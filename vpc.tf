variable "vpcs" {
  type = map(object({
    cidr = string
    tenancy = string
    tags = map(string)
  }))
  default = {
    "first" = {
        cidr = "10.0.0.0/16"
        tenancy = "default"
        tags = {
            "Name" = "VPC-ONE"
        }
    }
    "two" = {
       cidr = "10.0.1.0/16"
        tenancy = "default"
        tags = {
            "Name" = "VPC-Two"
        } 
    }
  }
}


resource "aws_vpc" "main" {
  for_each = var.vpcs
  cidr_block       = each.value["cidr"]
  instance_tenancy = each.value["tenancy"]

  tags = each.value["tags"]
}