##  In this project we plan to create an s3 bucket, enabled versionning, encryption, block it for public access
##  We will create an S3 bucket by using the aws_s3_bucket resource

# S3 bucket resource block
resource "aws_s3_bucket" "dev_Pro-s3" {
  bucket = "devpro-devbucket"
  acl = "private"
  tags = {
    Name = "Devops-Pro-S3"
  }

  # Prevent accidental deletion of this S3 bucket
  /* lifecycle {
    prevent_destroy = true
  } */
}

##  now add several extra layers of protection to this S3 bucket
##  First, use the aws_s3_bucket_versioning resource to enable 
##  versioning on the S3 bucket so that every update to a file in the bucket actually creates a new version of that file.

resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.dev_Pro-s3.id
  versioning_configuration {
    status = "Enabled"
  }
}

##  Second, use the aws_s3_bucket_server_side_encryption_configuration resource to
##  turn server-side encryption on by default for all data written to this S3 bucket


resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.dev_Pro-s3.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

## Third, use the aws_s3_bucket_public_access_block resource to block all public access to the S3 bucket

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.dev_Pro-s3.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

##  We will create a DynamoDB table to use for locking our statefile and avoid 2 engineers to apply at the same time

/* resource "aws_dynamodb_table" "terraform_locks" {
  name         = "devopspro-db"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
} */

## To delete the resource you need to manually delete the lock on the statefile
## Copy the dynamo db id and run the commmand
##  terraform force-unlock <dynamodb ib>
##  terraform destroy -lock=false


#----------------------------------upload a single object into S3 bucket-----------------#

resource "aws_s3_bucket_object" "first-object" { 
  bucket = data.aws_s3_bucket.devops-pro-buck.id  
  key    = "text.txt"
  source = "C:\\Users\\brist\\Devops-pro\\terraform-projects\\s3\\text.txt"
}

#------------------ upload a Multiobject into S3 bucket----------------------------------#

resource "aws_s3_bucket_object" "second-object" { 
  bucket = data.aws_s3_bucket.devops-pro-buck.id  
  for_each = fileset("C:\\Users\\brist\\Devops-pro","*")    # The files need to be locate on your local machine so change this path by your own path
  key    = each.key
  source = "C:\\Users\\brist\\Devops-pro\\${each.value}"
}


#--------------------------Create Object---------------------------------------------------#

resource "aws_s3_bucket_object" "third-object" { 
  bucket = data.aws_s3_bucket.devops-pro-buck.id  
  key    = "${var.my_folders}/"                                      
  acl = "private"
  content_type = "application/x-directory"
}


#--------------------------------S3 Objects inside Folder---------------------------------------#

resource "aws_s3_bucket_object" "fifth-object" { 
  bucket = data.aws_s3_bucket.devops-pro-buck.id  
  for_each = fileset("C:\\Users\\brist\\Devops-pro","*")    # The files need to be locate on your local machine so change this path by your own path
  key    = "${var.my_folders}/${each.key}"
  source = "C:\\Users\\brist\\Devops-pro\\${each.value}"
}
