resource "aws_vpc" "dev-pro" {
  cidr_block =  var.cidr_block
   tags = {
    Name = "vpc-pro-test"
    Environment = "devo-pro"
  }

}
resource "aws_subnet" "dev-pro-subN" {
  vpc_id     = aws_vpc.dev-pro.id
   cidr_block = var.cidr_block

  tags = {
    Name = "dev-pro-public_subnet"
  }
}

resource "aws_internet_gateway" "devopsgw" {
  vpc_id = aws_vpc.dev-pro.id

  tags = {
    Name = "devops_pro_igw"
  }
}



