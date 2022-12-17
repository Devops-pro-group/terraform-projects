terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# > 0.12 need to set terraform settings block
# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"
}

