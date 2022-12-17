resource "aws_vpc" "Devops-pro_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "tf-example"
  }
}