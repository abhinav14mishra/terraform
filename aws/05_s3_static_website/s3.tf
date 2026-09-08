resource "random_id" "bucket_suffix" {
  byte_length = 6
}

resource "aws_s3_bucket" "static_website" {
  bucket = "static-website-${random_id.bucket_suffix.hex}"
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.static_website.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket                  = aws_s3_bucket.static_website.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  # Depend on public access block to prevent policy creation race conditions
  depends_on = [aws_s3_bucket_public_access_block.public_access_block]

  bucket = aws_s3_bucket.static_website.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.static_website.arn}/*"
      }
    ]
  })
}

# Upload index.html to the bucket
resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.static_website.id
  key          = "index.html"
  source       = "./index.html" # Path to your local index.html file
  content_type = "text/html"                 # Explicitly set so browsers render instead of downloading
}

output "bucket_name" {
  value = aws_s3_bucket.static_website.bucket
}

output "website_endpoint" {
  value = aws_s3_bucket_website_configuration.website.website_endpoint
}

