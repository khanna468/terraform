variable "region" {
  type = string
  default = "ap-south-1"
}

variable "availability_zone_a" {
    description = "Availability Zone in the region"
    default = "ap-south-1a"
}

variable "availability_zone_b" {
    description = "Availability Zone in the region"
    default = "ap-south-1b"
}

variable "ami_map" {
  type = map
  default = {
    "us-east-1" = "ami-053b0d53c279acc90"
    "ap-south-1" = "ami-0f5ee92e2d63afc18"
  }
}

#variable "region_map" {}
