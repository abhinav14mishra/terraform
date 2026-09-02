

resource "random_id" "bucket_suffix" {
  byte_length = 6
}
resource "random_id" "bucket_suffix_2" {
  byte_length = 6
}
resource "aws_s3_bucket" "mumbai" {
  bucket = "sample-bucket-${random_id.bucket_suffix.hex}"
}
resource "aws_s3_bucket" "virginia" {
  bucket   = "sample-bucket-${random_id.bucket_suffix_2.hex}"
  provider = aws.virginia
}

output "mumbai_bucket_name" {
  value = aws_s3_bucket.mumbai.bucket
}
output "virginia_bucket_name" {
  value = aws_s3_bucket.virginia.bucket
}
