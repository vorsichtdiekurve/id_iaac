# variables.tf

variable "regions" {
   type    = list(string)
   default = ["us-east-1", "us-west-2"]
}

variable "bucket_name_prefix" {
  type    = string
  default = "id-iaac-aliases-s3-bucket"
}

variable "s3_versioning_on" {
  type    = string
  default = "Enabled"
}

variable "s3_glacier_transition_days" {
  type    = number
  default = 90
}

variable "s3_transition_storage_class" {
  type    = string
  default = "GLACIER"
}