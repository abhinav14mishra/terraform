terraform {
  backend "s3" {
    bucket       = "250509934912-tfstate-bucket"
    key          = "provider/default/terraform.tfstate"
    use_lockfile = true
    region       = "ap-south-1"
  }
}
