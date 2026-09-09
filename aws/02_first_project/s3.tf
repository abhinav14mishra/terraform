// Create an S3 bucket using the configured AWS provider.


resource "random_id" "bucket_suffix" {
  byte_length = 6
}

resource "aws_s3_bucket" "sample_bucket" {
  bucket = "sample-bucket-${random_id.bucket_suffix.hex}"
}

output "bucket_name" {
  value = aws_s3_bucket.sample_bucket.bucket
}
