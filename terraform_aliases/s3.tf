# s3.tf

resource "random_id" "bucket_suffix" {
  count       = length(var.regions) # notice new option - it will create N resources that can be accesses by [index]
  byte_length = 4 # specify how many bytes you want
}

resource "aws_s3_bucket" "s3_us_east_1" {
  # concatenating strings: "${variable}-${other_variable}rest_of_string"
  # accessing different random_id formats: random_id.bucket_suffix[i].hex / int / ...

  bucket = "${var.bucket_name_prefix}-${var.regions[0]}-${random_id.bucket_suffix[0].hex}" # create bucket name concatenating bucket_name_prefix, region, and suffix using random_id in hex format
}

resource "aws_s3_bucket_versioning" "s3_us_east_1" {
  bucket = aws_s3_bucket.s3_us_east_1.id

  versioning_configuration {
    status = var.s3_versioning_on
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "s3_us_east_1" {
  bucket = aws_s3_bucket.s3_us_east_1.id

  rule {
    id     = "transition-to-glacier"
    status = "Enabled"

    transition {
      days          = var.s3_glacier_transition_days # specify correct n days here
      storage_class = var.s3_transition_storage_class # specify correct storage_class (https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration)
    }
  }
}

# define rest of buckets and its configurations, each for the regions you specified, do not forget to pass valid provider to resource options as in aliases example.
#...

resource "aws_s3_bucket" "s3_us_west_2" {
  bucket = "${var.bucket_name_prefix}-${var.regions[1]}-${random_id.bucket_suffix[1].hex}"
  provider = aws.us_west_2
}

resource "aws_s3_bucket_versioning" "s3_us_west_2" {
  bucket = aws_s3_bucket.s3_us_west_2.id
  provider = aws.us_west_2

  versioning_configuration {
    status = var.s3_versioning_on
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "s3_us_west_2" {
  bucket = aws_s3_bucket.s3_us_west_2.id
  provider = aws.us_west_2

  rule {
    id     = "transition-to-glacier"
    status = "Enabled"

    transition {
      days          = var.s3_glacier_transition_days
      storage_class = var.s3_transition_storage_class
    }
  }
}