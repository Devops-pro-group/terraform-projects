module "vpc" {
  source     = "./vpc_module"
  aws-region = var.aws-region
  cidr_block = var.cidr_block
 # cidr_block  = var.cidr_block

}