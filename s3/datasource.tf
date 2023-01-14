data "aws_s3_bucket" "mukola" {
  bucket = "mukola1.k8.local"
}

resource "aws_s3_bucket_object" "mukola" {
  bucket = data.aws_s3_bucket.mukola.id
  key    = "first.txt"
  source = "~/Documents/S3//first.txt"
}