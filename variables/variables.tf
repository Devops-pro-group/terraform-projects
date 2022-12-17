variable "vpc_cidr_block" {
    description = "This is the cidr for our vpc"
    type = string
    default = "172.16.0.0/16"
  
}
variable "dev_region" {
    type = string
    default = "us-east-1"
  
}
