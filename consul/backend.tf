terraform {
  backend "s3" {
    bucket = "tf-state-ff857864"
    key = "consul.tfstate"
    region = "ap-south-1"
  }
}
