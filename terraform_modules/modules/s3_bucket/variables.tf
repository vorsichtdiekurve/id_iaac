variable "bucket_name_prefix" {
  type    = string
  default = "id-iaac-modules-s3-bucket"
  description = "S3 bucket name prefix"
}

variable "region" {
  type    = string
  default = "us-east-1"
  description = "AWS region"
}

variable "random_suffix" {
  type    = string
  default = "1a2b3c4d"
  description = "Random suffix"
}

variable "lifecycle_days" {
  type    = number
  default = 90
  description = "S3 retention period in days"
}

variable "lifecycle_storage_class" {
  type    = string
  default = "GLACIER"
  description = "Storage type for archived data"
}