terraform {
  backend "s3" {
    bucket = "tf-state-ff857864"
    key = "state.tfstate"
    region = var.region
  }
}
