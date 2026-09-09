// Store the static website example's Terraform state in S3.
terraform {
  backend "s3" {
    bucket       = "474265880032-tfstate-bucket"
    key          = "static-website/default/terraform.tfstate"
    use_lockfile = true
    region       = "ap-south-1"
  }
}
