terraform {
  backend "s3" {
    bucket       = "474265880032-tfstate-bucket"
    key          = "func_exp/default/terraform.tfstate"
    use_lockfile = true
    region       = "ap-south-1"
  }
}
