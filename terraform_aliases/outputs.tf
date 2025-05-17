# outputs.tf

output "bucket_arns" {
   value = {
      "${var.regions[0]}" = aws_s3_bucket.s3_us_east_1.arn,
      "${var.regions[1]}" = aws_s3_bucket.s3_us_west_2.arn
   }
}

output "bucket_regions" {
   value = {
      "${aws_s3_bucket.s3_us_east_1.id}" = var.regions[0],
      "${aws_s3_bucket.s3_us_west_2.id}" = var.regions[1]
   }
}

output "bucket_replication_status" {
  value = {
    "${aws_s3_bucket.s3_us_east_1.id}: var.regions[0]" = aws_s3_bucket_lifecycle_configuration.s3_us_east_1.rule[0].status,
    "${aws_s3_bucket.s3_us_west_2.id}: var.regions[1]" = aws_s3_bucket_lifecycle_configuration.s3_us_west_2.rule[0].status
  }
}