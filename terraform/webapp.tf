terraform {
  backend "s3" {
    bucket  = "davidlarsket.ch-ops"
    key     = "terraform/webapp.tfstate"
    region  = "us-east-1"
    profile = "terraform"
  }
}
